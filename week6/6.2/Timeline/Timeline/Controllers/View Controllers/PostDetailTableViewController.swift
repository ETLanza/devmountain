//
//  PostDetailTableViewController.swift
//  Timeline
//
//  Created by Eric Lanza on 8/7/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    //MARK: - Properties
    var post: Post?
    @IBOutlet weak var postImageView: UIImageView!
    
    //MARK: - IBOutlets
    @IBOutlet weak var followPostButton: UIButton!
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        updateViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(postCommentsChanged(_:)), name: PostController.PostCommentsChangedNotification, object: nil)
        
        guard let post = post else { return }
        
        PostController.shared.fetchCommentsFor(post: post)
    }
    
    //MARK: - IBActions
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add new comment", message: nil, preferredStyle: .alert)
        var commentTextField = UITextField()
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter comment"
            commentTextField = textfield
        }
        
        let okAction = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let post = self.post,
                let text = commentTextField.text,
                !text.isEmpty else { return }
            
            PostController.shared.addComment(toPost: post, text: text, completion: { (_) in
                self.updateViews()
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func followPostButtonTapped(_ sender: UIButton) {
        guard let post = post else { return }
        PostController.shared.toggleSubscriptionTo(commentsForPost: post) { (_, _, _) in
            self.updateViews()
        }
    }
    
    // MARK: - Helper Methods
    private func updateViews() {
        guard let post = post, isViewLoaded else { return }
        
        PostController.shared.checkSubscriptionTo(commentsForPost: post) { (subscribed) in
            DispatchQueue.main.async {
                self.followPostButton.setTitle(subscribed ? "Unfollow Post" : "Follow Post", for: .normal)
            }
        }
        
        DispatchQueue.main.async {
            self.postImageView.image = post.photo
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Notification Methods
    @objc func postCommentsChanged(_ notification: Notification) {
        guard let notificationPost = notification.object as? Post,
            let post = post, notificationPost === post else { return }
        updateViews()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        
        guard let comment = post?.comments[indexPath.row] else { return UITableViewCell() }
        
        cell.textLabel?.text = comment.text
        cell.detailTextLabel?.text = "\(comment.timestamp)"
        
        return cell
    }
}
