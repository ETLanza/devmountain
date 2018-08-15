//
//  PostListTableViewController.swift
//  Timeline
//
//  Created by Eric Lanza on 8/7/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController , UISearchResultsUpdating {
    
    //MARK: - Properties
    var searchController: UISearchController?
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        refreshPosts()
        
        if tableView.numberOfRows(inSection: 0) > 0 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(postsChanged(_:)), name: PostController.PostsChangedNotification, object: nil)
    }
    
    //MARK: - IBActions
    @IBAction func refreshControlActivated(_ sender: UIRefreshControl) {
        refreshPosts {
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return PostTableViewCell() }
        
        let posts = PostController.shared.posts
        cell.post = posts[indexPath.row]
        
        return cell
    }
    
    //MARK: - Search Controller
    func setUpSearchController() {
        let resultsController = UIStoryboard(name: "Main", bundle:  nil).instantiateViewController(withIdentifier: "SearchResultsTableViewController")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = true
        tableView.tableHeaderView = searchController?.searchBar
        
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let resultsViewController = searchController.searchResultsController as? SearchResultsTableViewController,
            let searchTerm = searchController.searchBar.text?.lowercased() {
            
            let posts = PostController.shared.posts
            let filteredPosts = posts.filter { $0.matches(searchTerm: searchTerm) }.map {$0 as SearchableRecord }
            resultsViewController.resultsArray = filteredPosts
            resultsViewController.tableView.reloadData()
        }
    }
    
    //MARK: - Notification Methods
    @objc func postsChanged(_ notification: Notification) {
        tableView.reloadData()
    }
    
    //MARK: - Private Methods
    private func refreshPosts(_ completion: (() -> Void)? = nil) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        PostController.shared.fetchPosts {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            completion?()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToPostDetail" {
            guard let index = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? PostDetailTableViewController else { return }
            let post = PostController.shared.posts[index.row]
            destinationVC.post = post
        }
        
        if segue.identifier == "segueToPostDetailFromSearch" {
            if let detailViewController = segue.destination as? PostDetailTableViewController,
                let sender = sender as? PostTableViewCell,
                let selectedIndexPath = (searchController?.searchResultsController as? SearchResultsTableViewController)?.tableView.indexPath(for: sender),
                let searchTerm = searchController?.searchBar.text?.lowercased() {
                
                let posts = PostController.shared.posts.filter({ $0.matches(searchTerm: searchTerm) })
                let post = posts[selectedIndexPath.row]
                
                detailViewController.post = post
            }
        }
    }
}
