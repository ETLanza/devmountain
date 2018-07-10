//
//  SwitchTableViewCell.swift
//  Alarm3
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: SwitchTableViewCellDelegate?
    
    @IBOutlet weak var timeTextField: UILabel!
    
    @IBOutlet weak var nameTextField: UILabel!
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    //MARK: - Actions
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        delegate?.switchCellSwitchValueChanged(cell: self)
    }
    
    //MARK: - Methods
    func updateViews(){
        if let alarm = alarm {
            timeTextField.text = alarm.fireTimeAsString
            nameTextField.text = alarm.name
            alarmSwitch.isOn = alarm.enabled
        }
    }
    
}
