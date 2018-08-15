//
//  Message.swift
//  BulletinBoard
//
//  Created by Eric Lanza on 8/6/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

struct Message {
    
    static let messageTypeKey = "Message"
    fileprivate static let messageTextKey = "messageText"
    fileprivate static let timestampKey = "timestamp"
    
    let messageText: String
    let timestamp: Date
    
    init(messageText: String) {
        self.messageText = messageText
        self.timestamp = Date()
    }
    
    init?(record: CKRecord) {
        guard let messageText = record[Message.messageTextKey] as? String,
            let timestamp = record[Message.timestampKey] as? Date else { return nil }
        self.messageText = messageText
        self.timestamp = timestamp
    }
}

extension CKRecord {
    convenience init(message: Message) {
        self.init(recordType: Message.messageTypeKey)
        
        self.setValue(message.messageText, forKey: Message.messageTextKey)
        self.setValue(message.timestamp, forKey: Message.timestampKey)
    }
}
