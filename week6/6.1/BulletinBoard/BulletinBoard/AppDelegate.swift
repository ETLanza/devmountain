//
//  AppDelegate.swift
//  BulletinBoard
//
//  Created by Eric Lanza on 8/6/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static let messageNotification = Notification.Name("MessageNotifications")
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (userDidAllow, error) in
            if let error = error {
                print("There was an error requesting notification authorization: \(error.localizedDescription)")
            }
            
            if userDidAllow == true {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        MessageController.shared.subscribeToNotifications { (error) in
            if let error = error {
                print("Error subscribing to APNS: \(error)")
            }
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error registering APNS: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        MessageController.shared.fetchAllMessages { (success) in
            if success {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: AppDelegate.messageNotification, object: self)
                }
            }
        }
    }
}

