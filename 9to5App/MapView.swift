//
//  MapView.swift
//  user-location
//
//  Created by Tomi Timutius on 30/03/25.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let gop9Parking = CLLocationCoordinate2D(latitude: -6.302399, longitude:106.652619)
    static let gop5Parking = CLLocationCoordinate2D(latitude: -6.303281, longitude: 106.6513888)
    static let testLocation = CLLocationCoordinate2D(latitude: -6.256427, longitude: 106.760818)
}

struct TravelEstimates {
    var distance: String?
    var duration: String?
    var travelTime: String?
}

struct MapView: View {
    // Locations
    @State var userPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State var gop: MapCameraPosition = .region(.init(center: CLLocationCoordinate2D(latitude: -6.303236, longitude: 106.652005), latitudinalMeters: 150, longitudinalMeters: 150))
    @State var home: MapCameraPosition = .region(.init(center: CLLocationCoordinate2D(latitude: -6.256624, longitude: 106.761006), latitudinalMeters: 150, longitudinalMeters: 150))
    
    // Variables
    @StateObject private var navigatorManager = NavigatorManager()
    @State private var nameDestination: String?
    @State private var destination: CLLocationCoordinate2D?
    @State private var travelEstimates = TravelEstimates()
    @State private var showBottomSheet = false
    @State private var isNavigationActive: Bool = false
    
    //        @State private var estimatedDistance: String?
    //    @State private var estimatedDuration: String?
    //    @State private var estimatedTravelTime: String?
    
    
    var body: some View {
        
        ZStack{
            Map(position: $gop){
                UserAnnotation()
                //            if let route = navigatorManager.route{
                //                MapPolyline(route)
                //                    .stroke(Color.pink, lineWidth: 3)
                //            }
                if !navigatorManager.routePoints.isEmpty {
                    MapPolyline(MKPolyline(coordinates: navigatorManager.routePoints, count: navigatorManager.routePoints.count))
                        .stroke(Color.blue, lineWidth: 5)
                }
                Annotation("GOP 9 Parking Lot", coordinate: .gop9Parking, anchor: .bottom){
                    Image(systemName: "car")
                        .padding(3)
                        .background(RoundedRectangle(cornerRadius: 5).fill(.background))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 2))
                        .onTapGesture {
                            nameDestination = "GOP 9 Parking Lot"
                            destination = .gop9Parking
                            print(nameDestination!)
                            navigatorManager.getDirectionsOnce(to: destination!)
                            travelEstimates.distance = navigatorManager.estimatedDistance
                            travelEstimates.duration = navigatorManager.estimatedDuration
                            travelEstimates.travelTime = navigatorManager.estimatedArrivalTime
                            
                            showBottomSheet = true
                        }
                }
                Annotation("GOP 5 Parking Lot", coordinate: .gop5Parking, anchor: .bottom){
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.background)
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 2)
                        Image(systemName: "car")
                            .padding(3)
                            .onTapGesture {
                                nameDestination = "GOP 5 Parking Lot"
                                destination = .gop5Parking
                                print(nameDestination!)
                                navigatorManager.getDirectionsOnce(to: destination!)
                                travelEstimates.distance = navigatorManager.estimatedDistance
                                travelEstimates.duration = navigatorManager.estimatedDuration
                                travelEstimates.travelTime = navigatorManager.estimatedArrivalTime
                                showBottomSheet = true
                            }
                    }
                }
            }
            .onAppear{
                CLLocationManager().requestWhenInUseAuthorization()
                nameDestination = "GOP 5 Parking Lot"
                navigatorManager.getDirectionsOnce(to: .gop5Parking)
                travelEstimates.distance = navigatorManager.estimatedDistance
                travelEstimates.duration = navigatorManager.estimatedDuration
                travelEstimates.travelTime = navigatorManager.estimatedArrivalTime
                
                showBottomSheet = true
            }
            .mapControls{
                MapUserLocationButton()
                MapCompass()
                MapPitchToggle()
                MapScaleView()
            }
            .mapStyle(.standard(elevation: .realistic))
            .onChange(of: isNavigationActive, initial: false) {
                if isNavigationActive == true {
                    navigatorManager.startUpdatingDirections(to: destination ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
                    
                } else if isNavigationActive == false{
                    navigatorManager.stopUpdatingDirections()
                    
                }
            }
            .onReceive(
                navigatorManager.$estimatedDistance
                    .combineLatest(
                        navigatorManager.$estimatedDuration,
                        navigatorManager.$estimatedArrivalTime
                    )
            ) { distance, duration, time in
                if let distance = distance, let duration = duration, let time = time {
                    travelEstimates = TravelEstimates(distance: distance, duration: duration, travelTime: time)
                }
            }
            VStack {
                Spacer()
                BottomSheetView(nameDestination: $nameDestination,
                                isNavigationActive: $isNavigationActive,
                                travelEstimates: $travelEstimates)
                .background(Color("SheetColor"))
                .transition(.move(edge: .bottom)) // This is the magic ✨
                .animation(.easeInOut, value: showBottomSheet)
            }
            
        }
    }
    
    
}

#Preview {
    MapView()
}
