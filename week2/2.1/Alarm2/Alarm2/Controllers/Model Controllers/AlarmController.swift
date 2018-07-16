//
//  AlarmController.swift
//  Alarm2
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import UserNotifications

class AlarmController {
    
    //MARK: - Shared Instances
    static let shared = AlarmController()
    
    
    //MARK: - Properties
    var alarms: [Alarm] = []
    
    
    //MARK: - CRUD Functions
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        saveToPersistentStorage()
        return alarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        saveToPersistentStorage()
    }
    
    func delete(alarm: Alarm) {
        guard let index = AlarmController.shared.alarms.index(of: alarm) else { return }
        AlarmController.shared.alarms.remove(at: index)
        saveToPersistentStorage()
    }
    
    //MARK: - Init
    init() {
        loadFromPersistentStorage()
    }
    
    //MARK: - MOCK DATA - UNUSED
    var mockAlarms: [Alarm] {
        
        let alarmOne = Alarm(fireTimeFromMidnight: 9000, name: "AlarmOne")
        let alarmTwo = Alarm(fireTimeFromMidnight: 4000, name: "AlarmTwo")
        let alarmThree = Alarm(fireTimeFromMidnight: 15000, name: "AlarmThree")
        
        return [alarmOne, alarmTwo, alarmThree]
    }
    
    //MARK: - Methods
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
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

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "Time's Up"
        content.body = "Your alarm named \(alarm.name) is done."
        content.sound = UNNotificationSound.default()
        
        guard let date = alarm.fireDate else { return }
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func cancelUserNotifications(for alarm: Alarm){
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [alarm.uuid])
    }
}
