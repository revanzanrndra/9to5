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
    
    @StateObject private var notifManager = NotificationsManager()
    @StateObject var notifDelegate = NotificationsDelegate()
    
    @AppStorage("alreadyParked") private var alreadyParked: Bool = false
    @AppStorage("savedName") private var textField: String = ""
    @AppStorage("notifNavigationTarget") var navigationTarget: String?
    
    // Timer
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    // Formatter waktu
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    func getTotalMinutes(from date: Date) -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        let totalMinutes = (hour * 60) + minute
        
        return totalMinutes
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                DescriptionView2(alreadyParked: $alreadyParked)
                    .padding(.bottom, 30)
                    .onReceive(timer) { _ in
                        currentTime = Date()
                    }
//                Button("Test Notification") {
//                    notifManager.testNotification()
//                }
//                Text(alreadyParked ? "Already parked" : "Not yet parked")
                
                VStack {
                    if getTotalMinutes(from: currentTime) < 480 { // 00:00 - 07:59 (480 minutes = 8 hours)
                        NormalClock()
                    } else if getTotalMinutes(from: currentTime) < 540 { // 08:00 - 08:59 (540 minutes = 9 hours)
                        PrePeakClock()
                    } else if getTotalMinutes(from: currentTime) < 1080 { // 09:00 - 17:59 (1080 minutes = 18 hours)
                        PeakTimeClock()
                    } else if getTotalMinutes(from: currentTime) <= 1439 { // 18:00 - 23:59 (1439 minutes = 23:59)
                        NormalClock()
                    }
                }
                .onReceive(timer) { _ in
                    currentTime = Date() // this triggers a re-evaluation of which clock to show
                    checkMidnight()
                }
                
                DescriptionView(alreadyParked: $alreadyParked)
                    .padding(.top, 30)
                    .onReceive(timer) { _ in
                        currentTime = Date() // this triggers a re-evaluation of which clock to show
                    }
                
                Spacer()
                
                Text("Out of spot? No problem!")
                    .padding(.top, 10)
                
                NavigationLink(destination: MapView()) {
                    Image(systemName: "mappin.and.ellipse.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color(.green))
                        .padding()
                }
                NavigationLink(destination: MapView(), tag: "navigateToGOP5", selection: $navigationTarget) {
                    EmptyView()
                }
                
                Text("Let’s navigate to GOP 5 🚘")
                    .padding(.top, 5)
            }
            .padding(.top)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Text("Hi, \(textField)")
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        
                        NavigationLink(destination: NameView(textField: $textField)) {
                            Image(systemName: "pencil.line")
                                .font(.system(size: 22))
                                .foregroundStyle(.black)
                        }
                    }
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
            UNUserNotificationCenter.current().delegate = notifDelegate
        }
    }
    
    private func checkMidnight() {
           let now = Date()
           let calendar = Calendar.current
           let hour = calendar.component(.hour, from: now)
           let minute = calendar.component(.minute, from: now)

           // Reset jika jam sudah lewat 12:00 AM
           if hour == 0 && minute == 0 {
               alreadyParked = false
           }
       }
}

#Preview {
    MainPageView()
}
