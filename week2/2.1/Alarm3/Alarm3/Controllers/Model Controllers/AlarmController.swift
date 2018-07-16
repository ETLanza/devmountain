//
//  AlarmController.swift
//  Alarm3
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
        let content = UNMutableNotificationContent()
        content.title = "Time's up!"
        content.body = "Your alarm titled \(alarm.name) is done"
        content.sound = UNNotificationSound.default()
        
        guard let fireDate = alarm.fireDate else { return }
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: fireDate)
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
    }
    
    //MARK: - Shared Instances
    static let shared = AlarmController()
    
    //MARK: - Properties
    var alarms: [Alarm] = []
    
    //MARK: - CRUD Functions
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        AlarmController.shared.alarms.append(alarm)
        saveToPersistentStorage()
        return alarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        saveToPersistentStorage()
        alarm.name = name
    }
    
    func delete(alarm: Alarm) {
        guard let index = AlarmController.shared.alarms.index(of: alarm) else { return }
        AlarmController.shared.alarms.remove(at: index)
        saveToPersistentStorage()
    }
    
    //MARK: - Methods
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    //MARK: - MOCK ALARMS - UNUSED
    var mockAlarms: [Alarm] {
        
        let alarmOne = Alarm(fireTimeFromMidnight: 90000, name: "AlarmOne")
        let alarmTwo = Alarm(fireTimeFromMidnight: 50000, name: "AlarmTwo")
        let alarmThree = Alarm(fireTimeFromMidnight: 1000, name: "AlarmThree")
        
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
                print("There was an error loading to persistant store")
                return
        }
        guard let alarms = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Alarm] else { return }
        self.alarms = alarms
    }
    
}
