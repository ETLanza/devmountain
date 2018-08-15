//
//  PostListTableViewController.swift
//  RedditC
//
//  Created by Eric Lanza on 7/26/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ETLPostController.shared().fetchPosts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("No go")
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ETLPostController.shared().posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell() }
        
        let post = ETLPostController.shared().posts[indexPath.row]
        
        cell.titleLabel.text = post.title
        
        ETLPostController.shared().fetchImage(for: post) { (image) in
            DispatchQueue.main.async {
                cell.thumbnailImageView.image = image ?? #imageLiteral(resourceName: "redditLogo")
            }
        }
        
        return cell
    }
}
