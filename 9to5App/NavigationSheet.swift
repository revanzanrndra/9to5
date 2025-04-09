//
//  NavigationSheet.swift
//  9to5App
//
//  Created by Tomi Timutius on 07/04/25.
//

import SwiftUI
import MapKit

struct TrailView: View {
    var body: some View {
        VStack(spacing: 3) { // Adjust spacing to control the dot positions
            Circle()
                .frame(width: 3, height: 3)
                .foregroundColor(.gray)
            Circle()
                .frame(width: 3, height: 3)
                .foregroundColor(.gray)
            Circle()
                .frame(width: 3, height: 3)
                .foregroundColor(.gray)
        }
    }
}

struct BottomSheetView: View {
    @Binding var nameDestination: String?
    @Binding var isNavigationActive: Bool
    @Binding var travelEstimates: TravelEstimates
    
    var body: some View {
        VStack {
            HStack {
                Text("Directions")
                    .font(.largeTitle)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                
                Spacer()
            }
            
            VStack {
                HStack(alignment: .top) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.blue)

                    Text("User Location")
                    
                    Spacer()
                }
                
                HStack() {
                    TrailView()
                        .padding(.leading, 8)
                        .padding(.bottom, 2)

                    Rectangle()
                        .frame(height: 0.5)
                    
                    Spacer()
                }

                HStack(alignment: .top) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)

                    Text(nameDestination ?? "Destination")

                    Spacer()
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                    .shadow(radius: 4)
            )
            
            Divider()
                
            HStack(alignment: .top) {
                Image(systemName: "clock")
                    .foregroundColor(.blue)
                VStack(alignment: .leading, spacing: 4) {
                    if let duration = travelEstimates.duration,
                       let distance = travelEstimates.distance,
                       let arrival = travelEstimates.travelTime {
                        Text("\(duration) • \(distance)")
                        Text(arrival)
                    } else {
                        Text("Loading...")
                    }
                }
                .font(.subheadline)
                
                Spacer()
                if isNavigationActive == true{
                    Button("Cancel") {
                        print("Mati bang navigasinya")
                        isNavigationActive = false
                    }
                    .padding(12)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                } else{
                    Button("Navigate") {
                        print("Menyala bang navigasinya")
                        isNavigationActive = true
                    }
                    .padding(12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding(.top, 3)
            .padding(.bottom, 6)
            .listStyle(.plain)
            
        }
        .padding()
        .background(.thinMaterial)
    }

}

#Preview {
    @Previewable @State var nameDestination: String? = "GOP 5 Parking Lot"
    @Previewable @State var isNavigationActive: Bool = false
    @Previewable @State var travelEstimates = TravelEstimates(
            distance: "150 m",
            duration: "1 min",
            travelTime: "10:00"
        )
    BottomSheetView(nameDestination: $nameDestination, isNavigationActive: $isNavigationActive, travelEstimates: $travelEstimates)
}
