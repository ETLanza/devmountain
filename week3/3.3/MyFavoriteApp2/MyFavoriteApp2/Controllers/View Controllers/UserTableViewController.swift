//
//  UserTableViewController.swift
//  MyFavoriteApp2
//
//  Created by Eric Lanza on 7/18/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserController.shared.getUsers { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func addUserButtonTapped(_ sender: UIBarButtonItem) {
        displayAlert()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.shared.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        let user = UserController.shared.users[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.favoriteApp
        
        return cell
    }
    
    //MARK: - Add User Alert Controller
    func displayAlert() {
        let alertController = UIAlertController(title: "Add a new user", message: nil, preferredStyle: .alert)
        var userNameTextField: UITextField?
        var favoriteAppTextField: UITextField?
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter user's name..."
            userNameTextField = textField
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter user's favorite app"
            favoriteAppTextField = textField
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (add) in
            guard let name = userNameTextField?.text, !name.isEmpty,
                let favoriteApp = favoriteAppTextField?.text, !favoriteApp.isEmpty else { return }
            UserController.shared.addUser(name: name, favoriteApp: favoriteApp, completion: { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
