//
//  SwitchTableViewCell.swift
//  Settings
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

    // Step 1
protocol SwitchTableViewCellDelegate: class {
    func switchTapped(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    
    var setting: Setting? {
        didSet {
            updateViews()
        }
    }
    
    // Step 2
    weak var delegate: SwitchTableViewCellDelegate?
    
    func updateViews() {
        guard let setting = setting else { return }
        
        if setting.isSet == true {
            self.backgroundColor = UIColor.yellow
        } else {
            self.backgroundColor = UIColor.white
        }
        
        
        iconImageView.image = setting.image
        nameLabel.text = setting.name
        settingSwitch.isOn = setting.isSet
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        //Step 3
        delegate?.switchTapped(cell: self)
    }
}
