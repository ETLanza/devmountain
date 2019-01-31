//
//  AlertManager.swift
//  PowerNapTimer
//
//  Created by Eric Lanza on 11/29/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit
import UserNotifications


class AlertManager {
    
    static func createLocalNotification(_ timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.subtitle = "Subtitle"
        content.body = "Body"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest.init(identifier: "Power Nap", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }
    
    static func cancelLocalNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
