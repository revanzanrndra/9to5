//
//  MainPageView.swift
//  LearnMapKit
//
//  Created by Tm Revanza Narendra Pradipta on 26/03/25.
//

import SwiftUI

struct MainPageView: View {
    @State private var currentTime = Date()
    @State private var isBellPressed = true
    @State private var alreadyParked: Bool = false
    @State private var textField: String = ""
    @StateObject private var notifManager = NotificationsManager()
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func checkPeakTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)
        let minute = calendar.component(.minute, from: currentDate)
        
        let totalMinutes = (hour * 60) + minute

        if totalMinutes < 480 { // 00:00 - 07:59 (480 minutes = 8 hours)
            print("Not peak time")
        } else if totalMinutes < 540 { // 08:00 - 08:59 (540 minutes = 9 hours)
            print("Towards peak time")
        } else if totalMinutes < 1080 { // 09:00 - 17:59 (1080 minutes = 18 hours)
            print("Peak time")
        } else if totalMinutes <= 1439 { // 18:00 - 23:59 (1439 minutes = 23:59)
            print("Not peak time")
        }
    }
    
    func bellPressed() {
        isBellPressed.toggle()
    }
    
    @ViewBuilder func bellSwitch() -> some View {
        if isBellPressed {
            Image(systemName: "bell.circle.fill")
                .font(.system(size: 30))
                .foregroundColor(Color(.green))
        } else {
            Image(systemName: "bell.slash.circle.fill")
                .font(.system(size: 30))
                .foregroundColor(.gray)
        }
    }
    
    // Date formatter for the time
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss" // 24-hour format with seconds
        // Alternative: "h:mm:ss a" for 12-hour format with AM/PM
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            if textField.isEmpty {
                NameView(textField: $textField)
            } else {
                VStack {
                    Spacer()
                    DescriptionView2(alreadyParked: $alreadyParked)
                        .padding(.bottom, 30)
                    Text(timeFormatter.string(from: currentTime))
                        .font(.system(size: 60, weight: .medium, design: .monospaced))
                        .padding()
                        .onReceive(timer) { _ in
                            // Update time every second
                            currentTime = Date()
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1))
                    
                    
//                    Spacer()
                    DescriptionView(alreadyParked: $alreadyParked)
                        .padding(.top, 30)
                    Spacer()
                    
                    VStack {
                        Text("Out of spot? No problem!")
                    }
                    .padding(.top, 10)
                    
                    NavigationLink(destination: MapView()) {
                        ZStack {
                            Image(systemName:"mappin.and.ellipse.circle.fill")
                                .font(.system(size: 80))
                                .foregroundColor(Color(.green))
                                .padding()
                        }
                    }
                    
                    Text(" Let’s navigate to GOP 5 🚘")
                        .padding(.top, 5)
                    
                }
                .padding(.top)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Hi, \(textField)")
                            .fontWeight(.bold)
                    }
                    
                    ToolbarItem {
                        Spacer()
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            bellPressed()
                        } label: {
                            bellSwitch()
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .onAppear {
            notifManager.permissionNotification { granted in
                if granted {
                    notifManager.scheduleDailyNotification(from: NotifContent.peakHour)
                } else {
                    print("Izin notifikasi ditolak.")
                }
            }
        }
    }
}

#Preview {
    MainPageView()
}

