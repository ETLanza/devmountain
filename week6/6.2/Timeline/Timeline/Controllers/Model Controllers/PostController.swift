//
//  PostController.swift
//  Timeline
//
//  Created by Eric Lanza on 8/7/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit
import CloudKit

class PostController {
    
    //MARK: - Shared Instance
    static let shared = PostController()
    
    //MARK: - Constant Strings
    static let PostsChangedNotification = Notification.Name("PostsChangedNotification")
    static let PostCommentsChangedNotification = Notification.Name("PostCommentsChangedNotification")
    
    //MARK: - Initilizer
    init() {
        subscribeToNewPosts()
    }
    
    //MARK: - Properties
    var posts: [Post] = [] {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: PostController.PostsChangedNotification, object: self)
            }
        }
    }
    
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    //MARK: - CRUD Functions
    @discardableResult func addComment(toPost post: Post,
                                       text: String,
                                       completion: @escaping ((Comment) -> Void) = { _ in }) -> Comment  {
        
        let comment = Comment(text: text, post: post)
        
        CloudKitManager.shared.saveRecord(comment.cloudKitRecord, database: publicDatabase) { (record, error) in
            if let error = error {
                print("Error saving record to public database: \(error)")
                return
            }
            
            guard let record = record else { return }
            
            comment.cloudKitRecordID = record.recordID
            post.comments.insert(comment, at: 0)
            
            completion(comment)
        }
        return comment
    }
    
    func createPostWith(image: UIImage, caption: String, completion: ((Post) -> Void)? ) {
        let imageData = UIImageJPEGRepresentation(image, 0.8)
        let post = Post(photoData: imageData)
        
        posts.insert(post, at: 0)
        
        let caption = addComment(toPost: post, text: caption)
        
        CloudKitManager.shared.saveRecord(post.cloudKitRecord, database: publicDatabase) { (record, error) in
            if let error = error {
                NSLog("Error saving record to public database: \(error)")
                completion?(post)
                return
            }
            
            guard let record = record else { completion?(post); return }
            
            post.cloudKitRecordID = record.recordID
            
            CloudKitManager.shared.saveRecord(caption.cloudKitRecord, database: self.publicDatabase) { (record, error) in
                if let error = error {
                    NSLog("Error saving new comment to CloudKit: \(error)")
                    return
                }
                caption.cloudKitRecordID = record?.recordID
                completion?(post)
            }
            
            self.addSubscriptionTo(commentsForPost: post, alertBody: "Someone commented on your post!")
            { (success, error) in
                if let error = error {
                    NSLog("Unable to save comment subscription: \(error)")
                }
            }
        }
        completion?(post)
    }
    
    //MARK: - CloudKit Methods
    func fetchCommentsFor(post: Post, completion: @escaping () -> Void = { }) {
        let sortDescriptor = NSSortDescriptor(key: Comment.timestampKey, ascending: false)
        
        let postReference = CKReference(record: post.cloudKitRecord, action: .deleteSelf)
        
        let predicate = NSPredicate(format: "%K == %@", Comment.postKey, postReference)
        
        CloudKitManager.shared.fetchRecordsOfType(Comment.commentTypeKey, predicate: predicate, database: publicDatabase, sortDescriptors: [sortDescriptor]) { (records, error) in
            if let error = error {
                print("Error fetching comment records: \(error)")
                return
            }
            
            guard let records = records else { return }
            
            
            let comments = records.compactMap { Comment(record: $0) }
            post.comments = comments
            
            completion()
        }
    }
    
    func fetchPosts(completion: @escaping (() -> Void) = { } ) {
        let sortDescriptors = NSSortDescriptor(key: Post.timestampKey, ascending: false)
        
        CloudKitManager.shared.fetchRecordsOfType(Post.postTypeKey, database: publicDatabase, sortDescriptors: [sortDescriptors]) { (records, error) in
            if let error = error {
                print("Error fetching post records: \(error)")
                return
            }
            
            guard let records = records else { return }
            
            let posts = records.compactMap { Post(record: $0) }
            
            let group = DispatchGroup()
            
            for post in posts {
                group.enter()
                self.fetchCommentsFor(post: post, completion: {
                    group.leave()
                })
            }
            
            group.notify(queue: DispatchQueue.main, execute: {
                self.posts = posts
                completion()
            })
        }
    }
    
    //MARK: - APNS Subscriptions
    func subscribeToNewPosts(completion: @escaping ((Bool, Error?) -> Void) = { _,_ in }) {
        
        let predicate = NSPredicate(value: true)
        
        CloudKitManager.shared.subscribe(Post.postTypeKey, predicate: predicate, database: publicDatabase, subscriptionID: "allPosts", contentAvailable: true, alertBody: "New Post Available!", options: .firesOnRecordCreation) { (subscription, error) in
            let success = subscription != nil
            completion(success, error)
        }
    }
    
    func checkSubscriptionTo(commentsForPost post: Post, completion: @escaping ((Bool) -> Void) = { _ in }) {
        guard let subscriptionID = post.cloudKitRecordID?.recordName else { completion(false); return }
        
        CloudKitManager.shared.fetchSubscription(subscriptionID, database: publicDatabase) { (subscription, error) in
            let success = subscription != nil
            completion(success)
        }
    }
    
    func addSubscriptionTo(commentsForPost post: Post,
                           alertBody: String?,
                           completion: @escaping ((Bool, Error?) -> Void) = {_,_ in } ) {
        
        guard let recordID = post.cloudKitRecordID else { fatalError("unable to create CloudKit reference in subscription.")}
        
        let predicate = NSPredicate(format: "post == %@", recordID)
        
        CloudKitManager.shared.subscribe(Comment.commentTypeKey, predicate: predicate, database: publicDatabase, subscriptionID: recordID.recordName, contentAvailable: true, alertBody: alertBody, desiredKeys: [Comment.textKey, Comment.postKey], options: .firesOnRecordCreation) { (subscription, error) in
            let success = subscription != nil
            completion(success, error)
        }
    }
    
    func removeSubscriptionTo(commentsForPost post: Post,
                              completion: @escaping ((Bool, Error?) -> Void) = { _,_ in } ) {
        
        guard let subscriptionID = post.cloudKitRecordID?.recordName else { completion(true, nil); return }
        
        CloudKitManager.shared.unsubscribe(subscriptionID, database: publicDatabase) { (subscription, error) in
            let success = subscription != nil
            completion(success, error)
        }
    }
    
    func toggleSubscriptionTo(commentsForPost post: Post,
                              completion: @escaping ((Bool, Bool, Error?) -> Void) = {_,_,_ in } ) {
        
        guard let subscriptionID = post.cloudKitRecordID?.recordName else {
            completion(false, false, nil); return
        }
        
        CloudKitManager.shared.fetchSubscription(subscriptionID, database: publicDatabase) { (subscription, error) in
            if subscription != nil {
                self.removeSubscriptionTo(commentsForPost: post) { (success, error) in
                    completion(success, false, error)
                }
            } else {
                self.addSubscriptionTo(commentsForPost: post, alertBody: "Someone commented on a post you follow!") { (success, error) in
                    completion(success, true, error)
                }
            }
        }
    }
}
