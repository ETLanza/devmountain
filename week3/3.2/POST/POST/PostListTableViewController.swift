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

    @IBAction func addPostButtonPressed(_ sender: UIBarButtonItem) {
        presentNewPostAlert()
    }
    
    
    @IBAction func resfreshControllerValueChanged(_ sender: UIRefreshControl) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        refreshControl?.beginRefreshing()
        postController.fetchPosts {
            self.reloadTableView()
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
        
        postController.fetchPosts {
            self.reloadTableView()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postController.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)

        let post = postController.posts[indexPath.row]
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row >= postController.posts.count - 1 {
            postController.fetchPosts(reset: false, completion: {
                self.reloadTableView()
            })
        }
    }
    
    //MARK: - Reload Views
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
    }
    
    //MARK: - New Post Alert Controller
    func presentNewPostAlert() {
        let alertController = UIAlertController(title: "New Post", message: "Enter a new post", preferredStyle: UIAlertControllerStyle.alert)
        
        var usernameTextField: UITextField?
        var messageTextField: UITextField?
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Username"
            usernameTextField = textField
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter message"
            messageTextField = textField
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (add) in
            guard let username = usernameTextField?.text, !username.isEmpty,
                let message = messageTextField?.text, !message.isEmpty
                else {
                    let errorAlertController = UIAlertController(title: "Uh-Oh", message: "You need to enter text into both textfields!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                    errorAlertController.addAction(okAction)
                    
                    self.present(errorAlertController, animated: true, completion: nil)
                    return
            }
            self.postController.addNewPostWith(username: username, text: message, completion: {
                self.reloadTableView()
            })
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
