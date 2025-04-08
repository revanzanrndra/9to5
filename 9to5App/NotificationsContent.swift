//
//  NotifContent.swift
//  UserNotification
//
//  Created by Tomi Timutius on 08/04/25.
//

import Foundation

struct NotifStructure {
    let title: String
    let body: String
    let hour: Int
    let minute: Int
}

// Contoh daftar notifikasi
struct NotifContent {
    static let peakHour = NotifStructure(
        title: "Peak Time Alert - GOP 9",
        body: "Full Parking Expected During Peak Hours 09.00 AM - 18.00 PM. Plan Ahead to Avoid Delays, Thank You!",
        hour: 8,
        minute: 30
    )
}
