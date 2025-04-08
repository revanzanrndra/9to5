//import UIKit
//import UserNotifications
//
//class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
//    
//    func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
//    ) -> Bool {
//        UNUserNotificationCenter.current().delegate = self
//        UIApplication.shared.registerForRemoteNotifications()
//        return true
//    }
//    
//    func application(
//        _ application: UIApplication,
//        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
//    ) {
//        let tokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
//        print("Device Token: \(tokenString)")
//    }
//    
//    func application(
//        _ application: UIApplication,
//        didFailToRegisterForRemoteNotificationsWithError error: Error
//    ) {
//        print("Failed to register for remote notifications: \(error.localizedDescription)")
//    }
//    
//    // Handle notification when the app is in foreground
//    func userNotificationCenter(
//        _ center: UNUserNotificationCenter,
//        willPresent notification: UNNotification,
//        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
//    ) {
//        completionHandler([.banner, .sound])
//    }
//}
