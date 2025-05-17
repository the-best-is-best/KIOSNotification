// The Swift Programming Language
// https://docs.swift.org/swift-book
//
//  LocalNotification.swift
//  LocalNotification
//
//  Created by Michelle Raouf on 09/03/2025.
//

import Foundation
import UserNotifications

@objc public class KIOSNotification: NSObject {
  
    @objc public static func initNotification(delegate: UNUserNotificationCenterDelegate) {
        UNUserNotificationCenter.current().delegate = delegate
        requestAuthorization()
    }

    @objc public static func showNotification(
        id: String,
        title: String,
        body: String,
        schedule: Bool,
        date: Date? = nil,
        data: [AnyHashable: Any]? = nil
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        // Add data to userInfo
        if let data = data {
            content.userInfo = data
        }

        let trigger: UNNotificationTrigger?
        if schedule, let date = date {
            let timeInterval = max(1, date.timeIntervalSinceNow)
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        } else {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        }

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }

    @objc public static func removeNotification(notificationId: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationId])
    }


    @objc public static func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Authorization request failed: \(error.localizedDescription)")
            } else {
                print("Authorization granted: \(granted)")
            }
        }
    }
}
