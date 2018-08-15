//
//  Comment.swift
//  Timeline
//
//  Created by Eric Lanza on 8/7/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

class Comment {
    
    //MARK: - Constant Strings
    static let commentTypeKey = "Comment"
    static let textKey = "text"
    static let postKey = "post"
    static let timestampKey = "timestamp"
    
    //MARK: - Properties
    let text: String
    let timestamp: Date
    var post: Post?
    var cloudKitRecordID: CKRecordID?
    
    var recordType: String {
        return Comment.commentTypeKey
    }
    
    var cloudKitRecord: CKRecord {
        
        guard let post = post else { fatalError("Commend does not have a Post relationship") }
        
        let postRecordID = post.cloudKitRecordID ?? post.cloudKitRecord.recordID
        let recordID = cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        let record = CKRecord(recordType: recordType, recordID: recordID)
        record[Comment.textKey] = text as CKRecordValue?
        record[Comment.timestampKey] = timestamp as CKRecordValue?
        record[Comment.postKey] = CKReference(recordID: postRecordID, action: .deleteSelf)
        
        return record
    }
    
    //MARK: - Initilizers
    init(text: String, timestamp: Date = Date(), post: Post?) {
        self.text = text
        self.timestamp = timestamp
        self.post = post
    }
    
    convenience required init?(record: CKRecord) {
        
        guard let timestamp = record.creationDate,
            let text = record[Comment.textKey] as? String else { return nil }
        
        self.init(text: text, timestamp: timestamp, post: nil)
        cloudKitRecordID = record.recordID
    }
    
    
}

//MARK: - SearchableRecord
extension Comment: SearchableRecord {
    
    func matches(searchTerm: String) -> Bool {
        return text.contains(searchTerm)
    }
}
