//
//  AlarmDetailTableViewController.swift
//  Alarm2
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    //MARK: - Properties
    var alarm: Alarm? {
        didSet {
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
        AlarmContontroller.shared.toggleEnabled(for: alarm)
        updateViews()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let date = DateHelper.thisMorningAtMidnight, let name = alarmTitleTextField.text else { return }
        let time = datePicker.date.timeIntervalSince(date)
        if let alarm = alarm {
            AlarmContontroller.shared.update(alarm: alarm, fireTimeFromMidnight: time, name: name)
        } else {
            let alarm = AlarmContontroller.shared.addAlarm(fireTimeFromMidnight: time, name: name)
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
    func updateViews() {
        guard let alarm = alarm,
            let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight,
            isViewLoaded else { enableButton.isHidden = true; return }
        
        datePicker.setDate(Date(timeInterval: alarm.fireTimeFromMidnight, since: thisMorningAtMidnight), animated: false)
        alarmTitleTextField.text = alarm.name
        
        if alarm.enabled {
            enableButton.setTitle("Disable", for: .normal)
            enableButton.setTitleColor(.red, for: .normal)
        } else {
            enableButton.setTitle("Enable", for: .normal)
            enableButton.setTitleColor(.white, for: .normal)
        }
        
        self.title = alarm.name
    }
    
    
}
