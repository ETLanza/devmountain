//
//  PostListTableViewController.swift
//  POST
//
//  Created by Eric Lanza on 7/16/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {

    let postController = PostController()
    
    @IBAction func resfreshControllerValueChanged(_ sender: UIRefreshControl) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        refreshControl?.beginRefreshing()
        postController.fetchPost {
            self.reloadTableViews()
            DispatchQueue.main.async {
                sender.endRefreshing()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        postController.fetchPost {
            self.reloadTableViews()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)

        let post = PostController.posts[indexPath.row]
        let timeInterval = post.timestamp
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        let dateString = dateFormatter.string(from: date)
        cell.textLabel?.text = post.text
        cell.detailTextLabel?.text = "\(post.username) - \(dateString)"

        return cell
    }
    
    func reloadTableViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
    }
}
