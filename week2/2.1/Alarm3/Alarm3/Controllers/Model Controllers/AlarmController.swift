//
//  AlarmController.swift
//  Alarm3
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class AlarmController {
    
    //MARK: - Shared Instances
    static let shared = AlarmController()
    
    //MARK: - Properties
    var alarms: [Alarm] = []
    
    //MARK: - CRUD Functions
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        AlarmController.shared.alarms.append(alarm)
        return alarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
    }
    
    func delete(alarm: Alarm) {
        guard let index = AlarmController.shared.alarms.index(of: alarm) else { return }
        AlarmController.shared.alarms.remove(at: index)
    }
    
    //MARK: - Methods
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    //MARK: - MOCK ALARMS
    var mockAlarms: [Alarm] {
        
        let alarmOne = Alarm(fireTimeFromMidnight: 90000, name: "AlarmOne")
        let alarmTwo = Alarm(fireTimeFromMidnight: 50000, name: "AlarmTwo")
        let alarmThree = Alarm(fireTimeFromMidnight: 1000, name: "AlarmThree")

        return [alarmOne, alarmTwo, alarmThree]
    }
    
    //MARK: - MOCK ALARM INIT
    init() {
        alarms = mockAlarms
    }
}
