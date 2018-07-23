//
//  MainTableViewController.swift
//  MyFavoriteApp
//
//  Created by Eric Lanza on 7/17/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var favoriteAppTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        PersonController.getPeople { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                
            }
        }
    }
    
    @IBAction func plusButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, !name.isEmpty,
            let favoriteApp = favoriteAppTextField.text, !favoriteApp.isEmpty else { return }
        PersonController.postPerson(name: name, favoriteApp: favoriteApp) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.nameTextField.text = ""
                    self.favoriteAppTextField.text = ""
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let person = PersonController.shared.people[indexPath.row]
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.favoriteApp
        
        return cell
    }
}
