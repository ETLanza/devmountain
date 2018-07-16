//
//  EntryTableViewController.swift
//  Journal
//
//  Created by Eric Lanza on 7/5/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class EntryTableViewController: UITableViewController {
    
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
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            EntryController.shared.remove(entry: EntryController.shared.entries[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editEntrySegue" {
            guard let destinationVC = segue.destination as? EntryDetailViewController else { return }
            guard let indexForEntry = tableView.indexPathForSelectedRow else { return }
            destinationVC.entry = EntryController.shared.entries[indexForEntry.row]
        }
        
    }
}
