//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {
    
    //MARK: - Properties
    var alarm: Alarm? = nil

    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var alarmEnableButton: UIButton!
    
    //MARK: - IBActions
    @IBAction func enableButtonTapped(_ sender: UIButton) {
        guard let alarm = alarm else { return }
        AlarmController.shared.toggleEnabled(for: alarm)
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = alarmNameTextField.text, let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
            let time = alarmDatePicker.date.timeIntervalSince(thisMorningAtMidnight)
        if let alarm = alarm {
            cancelUserNotifications(for: alarm)
            AlarmController.shared.update(alarm: alarm, fireTimeFromMidnight: time, name: title)
            scheduleUserNotifications(for: alarm)
        } else {
            let alarm = AlarmController.shared.addAlarm(fireTimeFromMidnight: time, name: title)
            scheduleUserNotifications(for: alarm)
            self.alarm = alarm
        }
       let _ = navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    //MARK: - Private Methods
    private func updateViews() {
        guard let alarm = alarm, let thisMorningAtMightnight = DateHelper.thisMorningAtMidnight, isViewLoaded else {
            alarmEnableButton.isHidden = true
            return
        }
        
        alarmDatePicker.setDate(Date(timeInterval: alarm.fireTimeFromMidnight, since: thisMorningAtMightnight), animated: false)
        alarmNameTextField.text = alarm.name
        
        alarmEnableButton.isHidden = false
        if alarm.enabled {
            alarmEnableButton.setTitle("Disable", for: .normal)
        } else {
            alarmEnableButton.setTitle("Enable", for: .normal)
        }
    }
}
