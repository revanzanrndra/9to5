//import SwiftUI
//import UserNotifications
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Peak-Time Notification")
//                .font(.largeTitle)
//                .padding()
//            
//            Button("Request Permission") {
//                requestNotificationPermission()
//            }
//            .padding()
//            
//            Button("Test Notification") {
//                sendTestNotification()
//            }
//            .padding()
//        }
//    }
//}
//
//class NineToFiveNotificationDelegate:NSObject, UNUserNotificationCenterDelegate{
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        
//    }
//}
//
//func requestNotificationPermission() {
//    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
//        if let error = error {
//            print("Permission error: \(error.localizedDescription)")
//        } else {
//            print(granted ? "Permission granted" : "Permission denied")
//        }
//    }
//}
//
//func sendTestNotification() {
//    let content = UNMutableNotificationContent()
//    content.title = "Peak Time Alert - GOP 9"
//    content.body = "Full Parking Expected During Peak Hours 09.00 AM - 18.00 PM. Plan Ahead to Avoid Delays, Thank You!"
//    content.sound = .default
//    
//    
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//    
//    //Singleton
//    let notifCenter = UNUserNotificationCenter.current()
//    notifCenter.delegate = NineToFiveNotificationDelegate()
//    
//    UNUserNotificationCenter.current().add(request) { error in
//        if let error = error {
//            print("Notification error: \(error.localizedDescription)")
//        } else {
//            print("Notification scheduled!")
//        }
//    }
//}
