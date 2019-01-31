//
//  SettingListTableViewController.swift
//  Settings
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class SettingListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsController.shared.settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SwitchTableViewCell else { return UITableViewCell() }
        
        let setting = SettingsController.shared.settings[indexPath.row]
        
        cell.delegate = self
        cell.setting = setting
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}

extension SettingListTableViewController: SwitchTableViewCellDelegate {
    func switchTapped(cell: SwitchTableViewCell) {
        guard let setting = cell.setting else { return }
        SettingsController.shared.isSetToggled(setting: setting)
        cell.updateViews()
    }
}
