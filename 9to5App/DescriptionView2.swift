//
//  DescriptionView2.swift
//  LearnMapKit
//
//  Created by Tm Revanza Narendra Pradipta on 27/03/25.
//

import SwiftUI

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
                Text("Brace Yourself for Peak Hours!")
            } else if totalMinutes < 1080 { // 09:00 - 17:59 (1080 minutes = 18 hours)
                if alreadyParked {
                    Text("No Need to Worry About Peak Hours.")
                } else {
                    Text("It's Peak Hours Time!")
                }
            } else if totalMinutes <= 1439 { // 18:00 - 23:59 (1439 minutes = 23:59)
                Text("Peak Hours Tomorrow - Plan Ahead!")
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
    DescriptionView2(alreadyParked: .constant(false))
}
