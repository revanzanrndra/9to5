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

        VStack {
            if totalMinutes < 480 { // 00:00 - 07:59 (480 minutes = 8 hours - ok)
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
                    Button {
                    } label: {
                        Text("Parked Successfully")
                            .foregroundStyle(.gray)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1))
                    }
                } else {
                    Button {
                        parkingConfirmed()
                    } label: {
                        Text("Parking Confirmed")
                            .foregroundStyle(.red)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 1))
                    }
                }
            } else if totalMinutes <= 1439 { // 18:00 - 23:59 (1439 minutes = 23:59)
                VStack {
                    Text("Prepare for Peak Time!")
                    Text("Stay updated and plan your schedule wisely.")
                }
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                currentTime = Date()
            }
        }
    }
    
    var body: some View {
        peakTimeCondition()
    }
}

struct DescriptionView2: View {
    @State private var currentTime = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Binding var alreadyParked: Bool
    
    @ViewBuilder func peakTimeCondition() -> some View {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime)
        let minute = calendar.component(.minute, from: currentTime)
        
        let totalMinutes = (hour * 60) + minute

        VStack {
            if totalMinutes < 480 { // 00:00 - 07:59 (480 minutes = 8 hours)
                Text("Peak Hours Tomorrow - Plan Ahead!")
            } else if totalMinutes < 540 { // 08:00 - 08:59 (540 minutes = 9 hours)
                Text("Peak hours ahead, time to park like a pro!")
            } else if totalMinutes < 1080 { // 09:00 - 17:59 (1080 minutes = 18 hours)
                if alreadyParked {
                    Text("You're all set!")
                } else {
                    Text("Peak hours just started ⏰")
                }
            } else if totalMinutes <= 1439 { // 18:00 - 23:59 (1439 minutes = 23:59)
                Text("Peak Hours Tomorrow - Plan Ahead!")
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                currentTime = Date()
            }
        }
        .bold()
        .font(.headline)
    }
    
    var body: some View {
        peakTimeCondition()
    }
}


#Preview {
    DescriptionView(alreadyParked: .constant(true))
    DescriptionView2(alreadyParked: .constant(true))
}
