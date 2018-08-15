//
//  User.swift
//  CKUsers
//
//  Created by Eric Lanza on 8/8/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    //MARK: - Constant Strings
    static let userTypeKey = "User"
    fileprivate static let usernameKey = "username"
    fileprivate static let firstNameKey = "firstName"
    fileprivate static let lastNameKey = "lastName"
    fileprivate static let appleUserReferenceKey = "appleUserReference"
    
    //MARK: - Properties
    let username: String
    let firstName: String
    let lastName: String
    var cloudKitRecordID: CKRecordID?
    let appleUserReference: CKReference
    
    //MARK: - Initilizers
    init(username: String, firstName: String, lastName: String, appleUserReference: CKReference) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.appleUserReference = appleUserReference
    }
    
    init?(ckRecord: CKRecord) {
        guard let username = ckRecord[User.usernameKey] as? String,
            let firstName = ckRecord[User.firstNameKey] as? String,
            let lastName = ckRecord[User.lastNameKey] as? String,
            let appleUserReference = ckRecord[User.appleUserReferenceKey] as? CKReference  else { return nil }
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.cloudKitRecordID = ckRecord.recordID
        self.appleUserReference = appleUserReference
    }
}

//MARK: - CKRecord User Init
extension CKRecord {
    convenience init(user: User) {
        let recordID = user.cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: User.userTypeKey)
        self.setValue(user.username, forKey: User.usernameKey)
        self.setValue(user.firstName, forKey: User.firstNameKey)
        self.setValue(user.lastName, forKey: User.lastNameKey)
        self.setValue(user.appleUserReference, forKey: User.appleUserReferenceKey)
        user.cloudKitRecordID = recordID
    }
}
