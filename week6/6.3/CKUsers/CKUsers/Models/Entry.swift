//
//  Entry.swift
//  CKUsers
//
//  Created by Eric Lanza on 8/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

class Entry {
    
    static let entryTypeKey = "Entry"
    fileprivate static let titleKey = "title"
    fileprivate static let bodyKey = "body"
    fileprivate static let timestampKey = "timestamp"
    fileprivate static let creatorReferenceKey = "creatorReference"
    
    var title: String
    var body: String
    let timestamp: Date
    var creatorReference: CKReference?
    
    var cloudkitRecordID: CKRecordID?
    
    init(title:String, body:String, creatorReference: CKReference) {
        self.title = title
        self.body = body
        self.timestamp = Date()
        self.creatorReference = creatorReference
    }
    
    init?(record: CKRecord) {
        guard let title = record[Entry.titleKey] as? String,
        let body = record[Entry.bodyKey] as? String,
        let timestamp = record[Entry.timestampKey] as? Date,
            let creatorReference = record[Entry.creatorReferenceKey] as? CKReference? else { return nil }
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.creatorReference = creatorReference
        self.cloudkitRecordID = record.recordID
    }
}

extension CKRecord {
    
    convenience init(entry: Entry) {
        
        let recordID = entry.cloudkitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        self.init(recordType: Entry.entryTypeKey, recordID: recordID)
        self.setValue(entry.title, forKey: Entry.titleKey)
        self.setValue(entry.body, forKey: Entry.bodyKey)
        self.setValue(entry.timestamp, forKey: Entry.timestampKey)
        self.setValue(entry.creatorReference, forKey: Entry.creatorReferenceKey)
        
        entry.cloudkitRecordID = recordID
        
    }
    
}
