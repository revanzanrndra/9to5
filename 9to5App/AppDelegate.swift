//
//  AppDelegate.swift
//  UserNotification
//
//  Created by Tomi Timutius on 09/04/25.
//

import Foundation
import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        print("Delegate disetel")
        return true
    }

    // Tampilkan notif saat app aktif
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }

    // Action buttonß
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        switch response.actionIdentifier {
        case "ALREADY_PARK_ACTION":
            print("User tapped: Already Park")
        case "NAVIGATE_TO_GOP5_ACTION":
            print("User tapped: Navigation to GOP5")
            UserDefaults.standard.set("navigateToGOP5", forKey: "notifNavigationTarget")
        default:
            break
        }
        completionHandler()
    }
}
