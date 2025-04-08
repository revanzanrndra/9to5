//
//  NotificationsManager.swift
//  9to5App
//
//  Created by Tomi Timutius on 08/04/25.
//

import Foundation
import UserNotifications

class NotificationsManager {
    
    func permissionNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Lokasi diberikan")
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
    
    func scheduleDailyNotification(title: String,body: String,hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Gagal menjadwalkan notifikasi: \(error.localizedDescription)")
            } else {
                print("Notifikasi dijadwalkan jam \(hour):\(minute)")
            }
        }
    }
    
    func testNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Pengingat Harian"
        content.body = "Ini adalah notifikasi yang dijadwalkan."
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Gagal menjadwalkan notifikasi: \(error.localizedDescription)")
            } else {
                print("Notifikasi dijadwalkan")
            }
        }
    }
}
