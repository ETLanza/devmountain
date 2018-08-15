//
//  MessageListViewController.swift
//  BulletinBoard
//
//  Created by Eric Lanza on 8/6/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var messageTextTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MessageController.shared.fetchAllMessages { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews),
                                               name: AppDelegate.messageNotification, object: nil)
    }
    
    @objc func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - IBActions
    @IBAction func postButtonTapped(_ sender: UIButton) {
        guard let messageText = messageTextTextField.text, !messageText.isEmpty else { return }
        MessageController.shared.postNewMessage(with: messageText) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        messageTextTextField.text = ""
    }
}

extension MessageListViewController: UITableViewDataSource {
    
    //MARK: - TableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageController.shared.messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        let message = MessageController.shared.messages[indexPath.row]
        
        cell.textLabel?.text = message.messageText
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        cell.detailTextLabel?.text = "\(message.timestamp)"
        
        return cell
    }
}
