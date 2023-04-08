//
//  NotificationManager.swift
//  FayHat
//
//  Created by enes öztürk on 7.04.2023.
//

import Foundation
import UIKit

class NotificationManager {
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { _, error in
            if let error = error {
                // Handle error
            } else {
                // Handle success
            }
        }
    }

    func handleEventNotificationIfNeeded(event: [Result]) {
        for e in event {
            if e.mag ?? 1.0 > 3.5 {
                sendLocalNotification()
            }
            break
        }
    }

    func sendLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Event Alert"
        content.body = "An eartquake with magnitude greater than 3.5 has occurred"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: "eventAlert", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
