//
//  ContactListTableViewController.swift
//  ContactsCK
//
//  Created by Eric Lanza on 8/10/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactController.shared.fetchAllContacts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.shared.contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let contact = ContactController.shared.contacts[indexPath.row]
        
        cell.textLabel?.text = contact.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contact = ContactController.shared.contacts[indexPath.row]
            ContactController.shared.delete(contact: contact) { (success) in
                if success {
                    DispatchQueue.main.async {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContactSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? ContactDetailViewController else { return }
            let contact = ContactController.shared.contacts[indexPath.row]
            destinationVC.title = "Edit Contact"
            destinationVC.contact = contact
        }
    }
}
