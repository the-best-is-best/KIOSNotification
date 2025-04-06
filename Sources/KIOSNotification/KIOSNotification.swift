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
    @MainActor // Ensures that the entire class runs on the main actor
    private static var notificationListener: (([AnyHashable: Any]) -> Void)?
    @MainActor // Ensures that the entire class runs on the main actor
    private static var lastNotificationData: [AnyHashable: Any]?

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

    @MainActor @objc public static func setNotificationListener(callback: @escaping ([AnyHashable: Any]) -> Void) {
        notificationListener = callback
        if let data = lastNotificationData {
            callback(data)
        }
        lastNotificationData = nil
    }

    @MainActor @objc public static func notifyNotification(data: [AnyHashable: Any]) {
        lastNotificationData = data
        notificationListener?(data)
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
