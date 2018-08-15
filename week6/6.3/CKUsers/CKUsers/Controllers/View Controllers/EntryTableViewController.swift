//
//  EntryTableViewController.swift
//  CKUsers
//
//  Created by Eric Lanza on 8/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class EntryTableViewController: UITableViewController {
    
    //MARK: - Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        let entry = EntryController.shared.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = "\(entry.timestamp)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = EntryController.shared.entries[indexPath.row]
            EntryController.shared.deleteEntryFromCloudKit(entry: entry) { (success) in
                if success {
                    EntryController.shared.entries.remove(at: indexPath.row)
                    DispatchQueue.main.async {                        
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editEntrySegue" {
            guard let index = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? EntryDetailViewController else { return }
            let entry = EntryController.shared.entries[index.row]
            destinationVC.entry = entry
        }
    }
}
