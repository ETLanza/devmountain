//
//  PopUpViewController.swift
//  PopUpMarkM
//
//  Created by Eric Lanza on 8/10/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    
    var showTimePicker = false
    
    var onSave: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if showTimePicker {
            titleLabel.text = "Select Time"
            datePicker.datePickerMode = .time
        } else {
            titleLabel.text = "Select Date"
            datePicker.datePickerMode = .date
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if let onSave = onSave {
            onSave()
        }
        dismiss(animated: true)
    }
    
    deinit {
        print("Deinit popup Called")
    }
}
