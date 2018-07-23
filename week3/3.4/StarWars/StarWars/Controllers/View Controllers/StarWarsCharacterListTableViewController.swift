//
//  StarWarsCharacterListTableViewController.swift
//  StarWars
//
//  Created by Eric Lanza on 7/19/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class StarWarsCharacterListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if StarWarsCharacterController.shared.characters.isEmpty {
            StarWarsCharacterController.getCharacters { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    // MARK: - Table view data source
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StarWarsCharacterController.shared.characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? StarWarsCharacterTableViewCell else { return UITableViewCell() }

        let character = StarWarsCharacterController.shared.characters[indexPath.row]
        
        
        cell.character = character

        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailVC" {
            guard let destinationVC = segue.destination as? StarWarsCharacterDetailViewController,
                let index = tableView.indexPathForSelectedRow else { return }
            destinationVC.character = StarWarsCharacterController.shared.characters[index.row]
        }
    }
}
