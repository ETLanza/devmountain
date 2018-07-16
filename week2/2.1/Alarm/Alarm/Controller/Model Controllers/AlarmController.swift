//
//  AlarmController.swift
//  Alarm
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm) {
        print("notific scheduled")
        let content = UNMutableNotificationContent()
        content.title = "Test"
        content.body = "Body Test"
        content.sound = UNNotificationSound.default()
        
        let components = Calendar.current.dateComponents([.year, .month, .day], from: alarm.fireDate!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content , trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            print(String(describing: error))
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [alarm.uuid])
    }
}

class AlarmController {
    
    init() {
        loadFromPersistentStorage()
        // MARK:- SET MOCK DATA - REMOVE TO REMOVE MOCK DATA
        self.alarms = self.mockAlarms
    }
    
    //MARK: - Shared Instance
    static let shared = AlarmController()
    
    //MARK: - Properties
    var alarms: [Alarm] = []
    
    //MARK: - CRUD Functions
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        let newAlarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(newAlarm)
        saveToPersistentStorage()
        return newAlarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        saveToPersistentStorage()
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.index(of: alarm) else { return }
        alarms.remove(at: index)
        saveToPersistentStorage()
    }
    
    //MARK: - Methods
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    //MARK: - MOCK DATA
    var mockAlarms: [Alarm] {
        let alarmOne = Alarm(fireTimeFromMidnight: 600, name: "Ten")
        let alarmTwo = Alarm(fireTimeFromMidnight: 900, name: "Fifteen")
        let alarmThree = Alarm(fireTimeFromMidnight: 300, name: "Five")
        return [alarmOne, alarmTwo, alarmThree]
    }
    
    //MARK: - Persistence Methods
    static private func persistentAlarmsFilePath() -> String? {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        guard let documentsDirectory = directories.first as NSString? else { return nil }
        return documentsDirectory.appendingPathComponent("alarms.plist")
    }
    
    private func saveToPersistentStorage() {
        guard let filePath = AlarmController.persistentAlarmsFilePath()
            else {
                print("There was an error saving to persistant store")
                return
        }
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: filePath)
        
    }
    
    private func loadFromPersistentStorage() {
        guard let filePath = AlarmController.persistentAlarmsFilePath()
            else {
                print("There was an error saving to persistant store")
                return
        }
        NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
    }
    
}

