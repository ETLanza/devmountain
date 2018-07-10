//
//  AlarmController.swift
//  Alarm
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class AlarmController {
    
    init() {
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
        return newAlarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.index(of: alarm) else { return }
        alarms.remove(at: index)
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
}
