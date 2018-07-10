//
//  AlarmController.swift
//  Alarm2
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class AlarmContontroller {
    
    //MARK: - Shared Instances
    static let shared = AlarmContontroller()
    
    
    //MARK: - Properties
    var alarms: [Alarm] = []
    
    
    //MARK: - CRUD Functions
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        return alarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
    }
    
    func delete(alarm: Alarm) {
        guard let index = AlarmContontroller.shared.alarms.index(of: alarm) else { return }
        AlarmContontroller.shared.alarms.remove(at: index)
    }
    
    //MARK: - MOCK DATA INIT
    init() {
        alarms = mockAlarms
    }
    
    //MARK: - MOCK DATA
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
}
