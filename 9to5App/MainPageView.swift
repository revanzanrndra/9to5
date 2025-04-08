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
    @AppStorage("savedName") private var textField: String = ""
    @StateObject private var notifManager = NotificationsManager()
    
    // Timer
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Formatter waktu
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                DescriptionView2(alreadyParked: $alreadyParked)
                    .padding(.bottom, 30)
                
                Text(timeFormatter.string(from: currentTime))
                    .font(.system(size: 60, weight: .medium, design: .monospaced))
                    .padding()
                    .onReceive(timer) { _ in
                        currentTime = Date()
                    }
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1))
                
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
                
                Text("Let’s navigate to GOP 5 🚘")
                    .padding(.top, 5)
            }
            .padding(.top)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Hi, \(textField)")
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isBellPressed.toggle()
                    }) {
                        Image(systemName: isBellPressed ? "bell.circle.fill" : "bell.slash.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(isBellPressed ? .green : .gray)
                    }
                }
            }
            .padding(.vertical)
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
