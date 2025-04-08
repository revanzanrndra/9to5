//
//  NotificationsManager.swift
//  UserNotification
//
//  Created by Tomi Timutius on 08/04/25.
//


//
//  NotificationsManager.swift
//  9to5App
//
//  Created by Tomi Timutius on 08/04/25.
//

import Foundation
import UserNotifications

class NotificationsManager: ObservableObject {
    
    func permissionNotification(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Gagal meminta izin notifikasi: \(error.localizedDescription)")
            }
            completion(granted)
        }
    }
    
    func scheduleDailyNotification(from notif: NotifStructure) {
        let content = UNMutableNotificationContent()
        content.title = notif.title
        content.body = notif.body
        content.sound = .default
        content.categoryIdentifier = "PARKING_REMINDER_CATEGORY"

        
        var dateComponents = DateComponents()
        dateComponents.hour = notif.hour
        dateComponents.minute = notif.minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Gagal menjadwalkan notifikasi: \(error.localizedDescription)")
            } else {
                print("Notifikasi dijadwalkan jam \(notif.hour):\(notif.minute)")
            }
        }
    }
    
    func testNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Pengingat Harian"
        content.body = "Ini adalah notifikasi yang dijadwalkan."
        content.sound = .default
        content.categoryIdentifier = "PARKING_REMINDER_CATEGORY"

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
    func registerNotificationCategories() {
        let alreadyParkAction = UNNotificationAction(
            identifier: "ALREADY_PARK_ACTION",
            title: "Already Park",
            options: [.foreground] // membuka aplikasi
        )

        let navigationAction = UNNotificationAction(
            identifier: "NAVIGATE_TO_GOP5_ACTION",
            title: "Navigation to GOP5",
            options: [.foreground] // juga membuka aplikasi
        )

        let category = UNNotificationCategory(
            identifier: "PARKING_REMINDER_CATEGORY",
            actions: [alreadyParkAction, navigationAction],
            intentIdentifiers: [],
            options: []
        )

        UNUserNotificationCenter.current().setNotificationCategories([category])
    }

}
