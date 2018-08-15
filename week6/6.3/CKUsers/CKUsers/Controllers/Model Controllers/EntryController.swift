//
//  EntryController.swift
//  CKUsers
//
//  Created by Eric Lanza on 8/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    //MARK: - Shared Instance
    static let shared = EntryController()
    
    //MARK: - Properties
    var entries: [Entry] = []
    
    //MARK: - CloudKit Public Database
    let publicDB = CKContainer.default().publicCloudDatabase
    
    //MARK: - CRUD Functions
    func createNewEntryWith(title: String, body: String, completion: @escaping ((Bool) -> Void)) {
        
        guard let user = UserController.shared.loggedInUser,
            let userRecordID = user.cloudKitRecordID else { completion(false); return }
        
        let reference = CKReference(recordID: userRecordID, action: .deleteSelf)
        
        let newEntry = Entry(title: title, body: body, creatorReference: reference)
        
        self.saveEntryToCloudKit(entry: newEntry)
        self.entries.append(newEntry)
        completion(true)
    }
    
    //MARK: - CloudKit Methods
    func saveEntryToCloudKit(entry: Entry) {
        let ckRecord = CKRecord(entry: entry)
        publicDB.save(ckRecord) { (_, error) in
            if let error = error {
                print("Error saving user to CloudKit: \(error)")
            }
        }
    }
    
    func deleteEntryFromCloudKit(entry: Entry, completion: @escaping ((Bool) -> Void)) {
        guard let recordID = entry.cloudkitRecordID else { return }
        publicDB.delete(withRecordID: recordID) { (_, error) in
            if let error = error {
                print("Error deleting record from CloudKit: \(error)")
                completion(false); return
            }
            completion(true)
        }
    }
    
    func modifyEntryInCloudKit(entry: Entry, withTitle title: String, body: String, completion: @escaping ((Bool) -> Void)) {
        entry.title = title
        entry.body = body
        
        let recordToModify = CKRecord(entry: entry)
        let modifyOp = CKModifyRecordsOperation(recordsToSave: [recordToModify], recordIDsToDelete: nil)
        
        modifyOp.savePolicy = .changedKeys
        modifyOp.queuePriority = .high
        modifyOp.qualityOfService = .userInteractive
        modifyOp.completionBlock = {
            completion(true)
        }
        publicDB.add(modifyOp)
    }
    
    func fetchEntriesFromCloudKit(completion: @escaping (Bool) -> Void ) {
        guard let userRecordID = UserController.shared.loggedInUser?.cloudKitRecordID else { completion(false); return }
        
        let predicate = NSPredicate(format: "creatorReference == %@", userRecordID)
        let query = CKQuery(recordType: Entry.entryTypeKey, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching entries from CloudKit: \(error)")
                completion(false); return
            }
            
            guard let records = records else { completion(false); return }
            
            let entries = records.compactMap { Entry(record: $0) }
            
            self.entries = entries
            
            completion(true)
        }
    }
}
