//
//  SearchResultsTableViewController.swift
//  Timeline
//
//  Created by Eric Lanza on 8/7/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    //MARK: - Properties
    var resultsArray: [SearchableRecord] = []
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as? PostTableViewCell,
        let result = resultsArray[indexPath.row] as? Post else { return UITableViewCell() }
        
        cell.post = result
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.presentingViewController?.performSegue(withIdentifier: "segueToPostDetailFromSearch", sender: cell)
    }
}
