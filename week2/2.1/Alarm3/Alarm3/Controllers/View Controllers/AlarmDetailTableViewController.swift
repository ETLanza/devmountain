//
//  AlarmDetailTableViewController.swift
//  Alarm3
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {

    //MARK: - Properties
    var alarm: Alarm? {
        didSet{
            if isViewLoaded {
                updateViews()
            }
        }
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var alarmTitleTextField: UITextField!
    
    @IBOutlet weak var enableButton: UIButton!
    
    //MARK: - Actions
    @IBAction func enableButtonPressed(_ sender: UIButton) {
        guard let alarm = alarm else { return }
        AlarmController.shared.toggleEnabled(for: alarm)
        if alarm.enabled {
        scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        updateViews()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let date = DateHelper.thisMorningAtMidnight, let name = alarmTitleTextField.text else { return }
        let fireTimeFromMidnight = datePicker.date.timeIntervalSince(date)
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireTimeFromMidnight: fireTimeFromMidnight, name: name)
            cancelUserNotifications(for: alarm)
            scheduleUserNotifications(for: alarm)
        } else {
            let alarm = AlarmController.shared.addAlarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
            scheduleUserNotifications(for: alarm)
            self.alarm = alarm
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Private Methods
    private func updateViews() {
        guard let date = DateHelper.thisMorningAtMidnight, let alarm = alarm else { enableButton.isHidden = true; return }
        
        datePicker.setDate(Date(timeInterval: alarm.fireTimeFromMidnight, since: date), animated: false)
        alarmTitleTextField.text = alarm.name
        
        if alarm.enabled {
            enableButton.setTitle("Disable", for: .normal)
            enableButton.backgroundColor = UIColor.red
        } else {
            enableButton.setTitle("Enable", for: .normal)
            enableButton.backgroundColor = UIColor.blue
        }
        self.title = alarm.name
    }

}
