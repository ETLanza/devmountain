//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

protocol  SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    var alarm: Alarm? {
        didSet{
            updateViews()
        }
    }
    
    @IBOutlet weak var alarmTimeLabel: UILabel!
    @IBOutlet weak var alarmNameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
            delegate?.switchCellSwitchValueChanged(cell: self)
    }
    
    func updateViews() {
        if let alarm = alarm {
            alarmTimeLabel.text = alarm.fireTimeAsString
            alarmNameLabel.text = alarm.name
            alarmSwitch.isOn = alarm.enabled
        }
    }
    
}
