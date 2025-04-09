//
//  PeakTimeClock.swift
//  LearnMapKit
//
//  Created by Tm Revanza Narendra Pradipta on 27/03/25.
//

import SwiftUI

// Clock Model
struct ClockModel2 {
    let hours: String
    let minutes: String
    let seconds: String
    
    static func getCurrentTime() -> ClockModel2 {
        let date = Date()
        let calendar = Calendar.current
        let hour = String(format: "%02d", calendar.component(.hour, from: date))
        let minute = String(format: "%02d", calendar.component(.minute, from: date))
        let second = String(format: "%02d", calendar.component(.second, from: date))
        return ClockModel2(hours: hour, minutes: minute, seconds: second)
    }
}

// Version 1: Peak Time (Bold, Red, Pulsating)
struct PeakTimeClock: View {
    @State private var time = ClockModel2.getCurrentTime()
    @State private var isPulsing = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 4) {
            Text(time.hours)
            Text(":")
            Text(time.minutes)
            Text(":")
            Text(time.seconds)
        }
        .font(.system(size: 60, weight: .medium, design: .monospaced))
        .foregroundColor(.red)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red.opacity(0.3), lineWidth: 1)
                )
        )
        .scaleEffect(isPulsing ? 1.05 : 1.0)
        .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isPulsing)
        .onAppear { isPulsing = true }
        .onReceive(timer) { _ in
            time = ClockModel2.getCurrentTime()
        }
    }
}

// Version 2: One Hour Until Peak (Orange, Glowing)
struct PrePeakClock: View {
    
    @State private var time = ClockModel2.getCurrentTime()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 4) {
            Text(time.hours)
            Text(":")
            Text(time.minutes)
            Text(":")
            Text(time.seconds)
        }
        .font(.system(size: 60, weight: .medium, design: .monospaced))
        .foregroundColor(.yellow)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.yellow.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow.opacity(0.3), lineWidth: 1)
                )
        )
        .onReceive(timer) { _ in
            time = ClockModel2.getCurrentTime()
        }
    }
}

// Version 3: Normal Time (Calm, Blue)
struct NormalClock: View {
    @State private var time = ClockModel2.getCurrentTime()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 4) {
            Text(time.hours)
            Text(":")
            Text(time.minutes)
            Text(":")
            Text(time.seconds)
        }
        .font(.system(size: 60, weight: .medium, design: .monospaced))
        .foregroundColor(.green)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.green.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green.opacity(0.3), lineWidth: 1)
                )
        )
        .onReceive(timer) { _ in
            time = ClockModel2.getCurrentTime()
        }
    }
}

#Preview {
    PeakTimeClock()
    PrePeakClock()
    NormalClock()
}
//    @State private var time = ClockModel2.getCurrentTime()
//    @State private var isPulsing = false
//
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//
//    var body: some View {
//        HStack(spacing: 4) {
//            Text(time.hours)
//            Text(":")
//            Text(time.minutes)
//            Text(":")
//            Text(time.seconds)
//        }
//        .font(.system(size: 48, weight: .bold, design: .monospaced))
//        .foregroundColor(.red)
//        .shadow(color: .red.opacity(0.5), radius: 10, x: 0, y: 0)
//        .scaleEffect(isPulsing ? 1.05 : 1.0)
//        .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isPulsing)
//        .onAppear { isPulsing = true }
//        .onReceive(timer) { _ in
//            time = ClockModel2.getCurrentTime()
//        }
//        .padding()
//        .background(
//            RoundedRectangle(cornerRadius: 15)
//                .fill(Color.black.opacity(0.8))
//        )
//    }
//    @State private var time = ClockModel2.getCurrentTime()
//
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//
//    var body: some View {
//        HStack(spacing: 4) {
//            Text(time.hours)
//            Text(":")
//            Text(time.minutes)
//            Text(":")
//            Text(time.seconds)
//        }
//        .font(.system(size: 40, weight: .semibold, design: .monospaced))
//        .foregroundColor(.orange)
//        .shadow(color: .orange.opacity(0.7), radius: 5, x: 0, y: 0)
//        .padding()
//        .background(
//            ZStack {
//                RoundedRectangle(cornerRadius: 12)
//                    .fill(Color.gray.opacity(0.2))
//                RoundedRectangle(cornerRadius: 12)
//                    .strokeBorder(
//                        AngularGradient(
//                            gradient: Gradient(colors: [.orange, .yellow, .orange]),
//                            center: .center
//                        ),
//                        lineWidth: 2
//                    )
//            }
//        )
//        .onReceive(timer) { _ in
//            time = ClockModel2.getCurrentTime()
//        }
//    }
