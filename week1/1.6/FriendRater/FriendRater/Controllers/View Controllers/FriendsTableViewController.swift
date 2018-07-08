//
//  FriendsTableViewController.swift
//  FriendRater
//
//  Created by Jayden Garrick on 7/7/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        FriendController.shared.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendController.shared.friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)
        
        let friend = FriendController.shared.friends[indexPath.row]
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = String(friend.rating)
        
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? FriendDetailViewController else { return }
        if segue.identifier == "editFriendSegue" {
            guard let index = tableView.indexPathForSelectedRow else { return }
            destinationVC.friend = FriendController.shared.friends[index.row]
        }
    }
}
