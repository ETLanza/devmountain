//
//  UserController.swift
//  CKUsers
//
//  Created by Eric Lanza on 8/8/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    //MARK: - Shared Instances
    static let shared = UserController()
    
    //MARK: - Properties
    var loggedInUser: User?
    
    //MARK: - Private Database
    let publicDB = CKContainer.default().publicCloudDatabase
    
    //MARK: - CRUD Functions
    func createNewUserWith(username: String, firstName: String, lastName: String, completion: @escaping (Bool) -> Void) {
        
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error {
                print("Error fetching user record ID: \(error)")
                completion(false); return
            }
            
            guard let recordID = recordID else { completion(false); return }
            
            let reference = CKReference(recordID: recordID, action: .deleteSelf)
            let newUser = User(username: username, firstName: firstName, lastName: lastName, appleUserReference: reference)
            self.saveUserToCloudKit(user: newUser)
            self.loggedInUser = newUser
            
            completion(true)
        }
    }
    
    //MARK: - CloudKit Functions
    func saveUserToCloudKit(user: User) {
        let ckRecord = CKRecord(user: user)
        publicDB.save(ckRecord) { (_, error) in
            if let error = error {
                print("Error saving user to CloudKit: \(error)")
            }
        }
    }
    
    func fetchUserFromCloudKit(completion: @escaping (Bool) -> Void) {
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error {
                print("Error fetching user record ID: \(error)")
                completion(false); return
            }
            
            guard let recordID = recordID else { completion(false); return }
            
            let predicate = NSPredicate(format: "appleUserReference == %@", recordID)
            let query = CKQuery(recordType: User.userTypeKey, predicate: predicate)
            
            self.publicDB.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
                if let error = error {
                    print("Error performing CloudKit query for users: \(error)")
                    completion(false); return
                }
                
                guard let records = records,
                let record = records.first else { completion(false); return }
                
                let user = User(ckRecord: record)
                
                self.loggedInUser = user
                completion(true)
            })
        }
    }
}
