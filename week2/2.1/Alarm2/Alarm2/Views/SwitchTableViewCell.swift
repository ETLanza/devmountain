//
//  SwitchTableViewCell.swift
//  Alarm2
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
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    //MARK: - Child Delegate
    weak var delegate: SwitchTableViewCellDelegate?
    
    //MARK: - Actions
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        delegate?.switchCellSwitchValueChanged(cell: self)
    }
    
    //MARK: - Methods
    func updateViews() {
        guard let alarm = alarm else { return }
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }

}
