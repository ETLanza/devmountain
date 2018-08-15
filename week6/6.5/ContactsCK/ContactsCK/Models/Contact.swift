//
//  Contact.swift
//  ContactsCK
//
//  Created by Eric Lanza on 8/10/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

class Contact: Equatable {
    
    //MARK: - Constant Strings
    static let typeKey = "Contact"
    fileprivate static let nameKey = "name"
    fileprivate static let phoneNumberKey = "phoneNumber"
    fileprivate static let emailAddressKey = "emailAddress"
    
    //MARK: - Properties
    var name: String
    var phoneNumber: String?
    var emailAddress: String?
    var recordID: CKRecordID?
    
    //MARK: - Initilizers
    init(name: String, phoneNumber: String?, emailAddress: String?) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
    }
    
    init?(record: CKRecord) {
        guard let name = record[Contact.nameKey] as? String,
            let phoneNumber = record[Contact.phoneNumberKey] as? String,
            let emailAddress = record[Contact.emailAddressKey] as? String else { return nil }
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
    }
    
    //MARK: - Helper Methods
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.recordID == rhs.recordID
    }
}

//MARK: - CKRecord Convenience Initilizer
extension CKRecord {
    convenience init(contact: Contact) {
        let recordID = contact.recordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: Contact.typeKey, recordID: recordID)
        self.setValue(contact.name, forKey: Contact.nameKey)
        self.setValue(contact.phoneNumber, forKey: Contact.phoneNumberKey)
        self.setValue(contact.emailAddress, forKey: Contact.emailAddressKey)
        contact.recordID = recordID
    }
}
