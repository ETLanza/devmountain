//
//  JournalListTableViewController.swift
//  Journal
//
//  Created by Eric Lanza on 7/5/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class JournalListTableViewController: UITableViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var newJournalTitleText: UITextField!
    
    //MARK: - IBActions
    
    @IBAction func addJournalButton(_ sender: UIBarButtonItem) {
        newJournalTitleText.isHidden = false
    }
    
    //MARK: - Text Field Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == newJournalTitleText {
            guard let text = textField.text, text != "" else { return true }
            JournalController.addJournalWith(title: text)
            textField.text = ""
            textField.resignFirstResponder()
            textField.isHidden = true
            tableView.reloadData()
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JournalController.loadFromPersistentStore()
        self.newJournalTitleText.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.shared.journals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        let journal = JournalController.shared.journals[indexPath.row]
        cell.textLabel?.text = journal.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            JournalController.deleteJournal(JournalController.shared.journals[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToEntryListTVC" {
            guard let destinationVC = segue.destination as? EntryListTableViewController else { return }
            guard let index = tableView.indexPathForSelectedRow else { return }
            destinationVC.journal = JournalController.shared.journals[index.row]
        }
    }
}
