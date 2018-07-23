//
//  iTunesItemListViewController.swift
//  iTunesSearch
//
//  Created by Eric Lanza on 7/19/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class iTunesItemListViewController: UIViewController {
    
    var iTunesItems = [iTunesItem]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        
    }
}

extension iTunesItemListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iTunesItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? iTunesItemTableViewCell else { return UITableViewCell() }
        
        let iTunesItem = iTunesItems[indexPath.row]
        
        iTunesItemController.getImage(for: iTunesItem) { (image) in
            cell.iTunesItemImage = image
        }
        
        cell.iTunesItem = iTunesItem
        
        return cell
    }
}

extension iTunesItemListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        iTunesItemController.getItunesItems(for: searchTerm) { (iTunesItems) in
            guard let iTunesItems = iTunesItems else { return }
            self.iTunesItems = iTunesItems
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

