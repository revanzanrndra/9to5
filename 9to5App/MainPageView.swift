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
    @AppStorage("alreadyParked") private var alreadyParked: Bool = false
    @AppStorage("savedName") private var textField: String = ""
    @StateObject private var notifManager = NotificationsManager()
    @AppStorage("notifNavigationTarget") var notifNavigationTarget: String?
    
    // Timer
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Formatter waktu
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    func getTotalMinutes() -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime)
        let minute = calendar.component(.minute, from: currentTime)
        
        let totalMinutes = (hour * 60) + minute
        
        return totalMinutes
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                DescriptionView2(alreadyParked: $alreadyParked)
                    .padding(.bottom, 30)
                Button("Test Notification") {
                    notifManager.testNotification()
                }
                
                VStack {
                    if getTotalMinutes() < 480 { // 00:00 - 07:59 (480 minutes = 8 hours)
                        NormalClock()
                    } else if getTotalMinutes() < 540 { // 08:00 - 08:59 (540 minutes = 9 hours)
                        PrePeakClock()
                    } else if getTotalMinutes() < 1080 { // 09:00 - 17:59 (1080 minutes = 18 hours)
                        PeakTimeClock()
                    } else if getTotalMinutes() <= 1439 { // 18:00 - 23:59 (1439 minutes = 23:59)
                        NormalClock()
                    }
                }
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        currentTime = Date()
                    }
                }
                
                DescriptionView(alreadyParked: $alreadyParked)
                    .padding(.top, 30)
                
                Spacer()
                
                Text("Out of spot? No problem!")
                    .padding(.top, 10)
                
                NavigationLink(destination: MapView()) {
                    Image(systemName: "mappin.and.ellipse.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color(.green))
                        .padding()
                }
                NavigationLink(destination: MapView(), tag: "navigateToGOP5", selection: $notifNavigationTarget) {
                    EmptyView()
                }
                
                Text("Let’s navigate to GOP 5 🚘")
                    .padding(.top, 5)
            }
            .padding(.top)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Hi, \(textField)")
                        .fontWeight(.bold)
                }
            }
            .padding(.vertical)
        }
        .onAppear {
            notifManager.registerNotificationCategories()
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
