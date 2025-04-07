//
//  NavigatorManager.swift
//  user-location
//
//  Created by Tomi Timutius on 27/03/25.
//

import Foundation
import MapKit
import SwiftUI

extension MKPolyline {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }
}

@MainActor
class NavigatorManager: ObservableObject {
    @Published var routePoints: [CLLocationCoordinate2D] = []
//    @Published var routePolyline: MKPolyline?
    private var isUpdatingRoute: Bool = false
    private var isFirstRoute: Bool = true
    private var task: Task<Void, Never>?
    
    @Published var estimatedDistance: String?  // "150m" atau "1.2km"
    @Published var estimatedDuration: String?  // "1 min" atau "5 min"
    @Published var estimatedArrivalTime: String?  // "10:30"
    

    func startUpdatingDirections(to destination: CLLocationCoordinate2D) {
        isUpdatingRoute = true
        let targetDestination = destination
//        isFirstRoute = true // 🔹 Set agar animasi berjalan pertama kali
        task?.cancel()
        task = Task {
            while isUpdatingRoute {
                await getdirections(to: targetDestination)
                try? await Task.sleep(nanoseconds: 3_000_000_000)
            }
        }
    }

    func stopUpdatingDirections() {
        isUpdatingRoute = false
        task?.cancel()
        task = nil
        routePoints.removeAll()
    }

    func getCurrentLocation() async -> CLLocationCoordinate2D? {
        let updates = CLLocationUpdate.liveUpdates()
        do {
            let update = try await updates.first { $0.location?.coordinate != nil }
            return update?.location?.coordinate
        } catch {
            print("Can't get user current location")
            return nil
        }
    }

    func getdirections(to destination: CLLocationCoordinate2D) async {
        guard let userLocation = await getCurrentLocation() else { return }

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: .init(coordinate: userLocation))
        request.destination = MKMapItem(placemark: .init(coordinate: destination))
        request.transportType = .automobile

        do {
            let directions = try await MKDirections(request: request).calculate()
            if let newRoute = directions.routes.first {
                
                estimatedDistance = formatDistance(newRoute.distance)
                estimatedDuration = formatDuration(newRoute.expectedTravelTime)
                estimatedArrivalTime = formatArrivalTime(from: newRoute.expectedTravelTime)
                
                if isFirstRoute {
                    await animateRouteDrawing(newRoute.polyline) // 🔹 Animasi pertama kali
                    isFirstRoute = false // 🔹 Selanjutnya langsung update tanpa animasi
                } else {
                    await MainActor.run {
                        routePoints = newRoute.polyline.coordinates // 🔹 Langsung update
                    }
                }
            }
        } catch {
            print("Error calculating directions: \(error.localizedDescription)")
        }
    }

    func getDirectionsOnce(to destination: CLLocationCoordinate2D) {
        task?.cancel()
        isFirstRoute = true
        task = Task {
            await getdirections(to: destination)
        }
    }

    /// **Animasi Menampilkan Rute Sekali Saja**
    private func animateRouteDrawing(_ polyline: MKPolyline) async {
        let coords = polyline.coordinates
        routePoints.removeAll()
        
        for i in 0..<coords.count {
            await MainActor.run {
                withAnimation(.easeInOut(duration: 0.1)) {
                    routePoints.append(coords[i])
                }
            }
            try? await Task.sleep(nanoseconds: 50_000_000) // 50ms delay per titik
        }
    }
    
    private func formatArrivalTime(from travelTime: TimeInterval) -> String {
        let arrivalDate = Date().addingTimeInterval(travelTime)
        let formatter = DateFormatter()
        formatter.timeStyle = .short // Format: "10:30 AM"
        return formatter.string(from: arrivalDate)
    }
    
    private func formatDistance(_ meters: CLLocationDistance) -> String {
        if meters >= 1000 {
            return String(format: "%.1f km", meters / 1000)
        } else {
            return String(format: "%.0f m", meters)
        }
    }

    private func formatDuration(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds / 60)
        return minutes > 0 ? "\(minutes) min" : "1 min"
    }

}
