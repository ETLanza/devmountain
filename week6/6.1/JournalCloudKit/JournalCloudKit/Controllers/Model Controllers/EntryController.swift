//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by Eric Lanza on 8/6/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    func save(entry: Entry, completion: @escaping (Bool) -> Void ) {
        
        let record = CKRecord(entry: entry)
        
        privateDB.save(record) { (record, error) in
            if let error = error {
                print("Error saving to cloudkid: \(error)")
                completion(false); return
            }
            self.entries.append(entry)
            completion(true)
        }
    }
    
    func addEntryWith(title: String, bodyText: String, completion: @escaping (Bool) -> Void ) {
        let newEntry = Entry(title: title, bodyText: bodyText)
        
        save(entry: newEntry) { (success) in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func fetchEntries(completion: @escaping (Bool) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Entry.entryTypeKey, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("There was an error fetching entries from cloudkit: \(error)")
                completion(false); return
            }
            
            guard let records = records else { completion(false); return }
            
            let entriesArray = records.compactMap { Entry(record: $0) } 
            
            self.entries = entriesArray
            completion(true)
        }
    }
}
