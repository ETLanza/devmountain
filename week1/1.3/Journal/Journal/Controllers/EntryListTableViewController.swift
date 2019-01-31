//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Eric Lanza on 7/5/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    var journal: Journal?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (journal?.entries.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let entry = journal?.entries[indexPath.row]
        cell.textLabel?.text = entry?.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let journal = self.journal else { return }
            JournalController.deleteEntry(journal.entries[indexPath.row], from: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? EntryViewController {
            if segue.identifier == "editEntrySegue" {
                guard let entryIndex = tableView.indexPathForSelectedRow else { return }
                destinationVC.entry = journal?.entries[entryIndex.row]
            }
            destinationVC.journal = self.journal
        }
    }
}
