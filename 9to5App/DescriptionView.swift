//
//  DescriptionView.swift
//  LearnMapKit
//
//  Created by Tm Revanza Narendra Pradipta on 27/03/25.
//

import SwiftUI

struct DescriptionView: View {
    @State private var currentTime = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Binding var alreadyParked: Bool
    
    func parkingConfirmed() {
        alreadyParked.toggle()
    }
    
    @ViewBuilder func peakTimeCondition() -> some View {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime)
        let minute = calendar.component(.minute, from: currentTime)
        
        let totalMinutes = (hour * 60) + minute

        if totalMinutes < 480 { // 00:00 - 07:59 (480 minutes = 8 hours)
            VStack {
                Text("Prepare for Peak Time!")
                Text("Stay updated and plan your schedule wisely.")
            }
        } else if totalMinutes < 540 { // 08:00 - 08:59 (540 minutes = 9 hours)
            VStack {
                Text("Full parking expected during peak hours")
                Text("9:00 AM - 18:00 PM")
                
                Text("Plan ahead to avoid delays. Thank you!")
            }
        } else if totalMinutes < 1080 { // 09:00 - 17:59 (1080 minutes = 18 hours)
            if alreadyParked {
                VStack {
                    Text("Parked Successfully!")
                        .padding(.bottom, 10)
                    Text("You're all set. Have a great day! 🚗✨")
                }
            } else {
                Button {
                    parkingConfirmed()
                } label: {
                    Text("Parking Confirmed")
                        .foregroundStyle(.black)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1))
                }
            }
        } else if totalMinutes <= 1439 { // 18:00 - 23:59 (1439 minutes = 23:59)
            VStack {
                Text("Prepare for Peak Time!")
                Text("Stay updated and plan your schedule wisely.")
            }

        }
    }
    
    var body: some View {
        peakTimeCondition()
    }
}

#Preview {
    DescriptionView(alreadyParked: .constant(true))
}
