//
//  AlarmListTableViewController.swift
//  Alarm2
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmContontroller.shared.alarms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as? SwitchTableViewCell else { return UITableViewCell() }
        
        cell.alarm = AlarmContontroller.shared.alarms[indexPath.row]
        cell.updateViews()
        cell.delegate = self
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AlarmContontroller.shared.alarms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editAlarmSegue" {
            guard let destinationVC = segue.destination as? AlarmDetailTableViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
            let alarm = AlarmContontroller.shared.alarms[indexPath.row]
            destinationVC.alarm = alarm
        }
    }
}

//MARK: - SwitchTableViewCellDelegate conformance
extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        guard let alarm = cell.alarm else { return }
        AlarmContontroller.shared.toggleEnabled(for: alarm)
        tableView.reloadData()
    }
}
