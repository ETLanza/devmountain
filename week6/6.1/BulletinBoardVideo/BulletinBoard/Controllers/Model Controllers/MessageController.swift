//
//  MessageController.swift
//  BulletinBoard
//
//  Created by Eric Lanza on 8/6/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

class MessageController {
    
    //MARK: - Shared Instance
    static let shared = MessageController()
    
    //MARK: - Properties
    var messages: [Message] = []
    
    //MARK: - Public Cloud Database
    let publicDB = CKContainer.default().publicCloudDatabase
    
    //MARK: - CRUD Functions
    func postNewMessage(with messageText: String, completion: @escaping (Bool) -> Void) {
        
        let newMessage = Message(messageText: messageText)
        let messageAsRecord = CKRecord.init(message: newMessage)
        
        publicDB.save(messageAsRecord) { (_, error) in
            if let error = error {
                print("Error saving to public DB: \(error)")
                completion(false)
                return
            }
            
            self.messages.append(newMessage)
            completion(true)
        }
    }
    
    func fetchAllMessages(completion: @escaping (Bool) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: Message.messageTypeKey, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error loading messages from DB: \(error)")
                completion(false); return
            }
        
            guard let records = records else { completion(false); return }
            let arrayOfMessages = records.compactMap { Message(record: $0) }
            self.messages = arrayOfMessages
            completion(true)
        }
    }
}
