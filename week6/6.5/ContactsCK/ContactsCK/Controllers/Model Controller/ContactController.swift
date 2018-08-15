//
//  ContactController.swift
//  ContactsCK
//
//  Created by Eric Lanza on 8/10/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    //MARK: - Shared Instance
    static let shared = ContactController()
    
    //MARK: - Private Database
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    //MARK: - Properties
    var contacts: [Contact] = []
    
    //MARK: - CRUD Functions
    func createNewContactWith(name: String, phoneNumber: String?, emailAddress: String?,  completion: @escaping (Bool) -> Void) {
        let newContact = Contact(name: name, phoneNumber: phoneNumber, emailAddress: emailAddress)
        saveContactToCloudKit(contact: newContact) { (_, error) in
            if let error = error {
                print("Error saving new contact: \(error.localizedDescription)")
                completion(false); return
            }
            self.contacts.append(newContact)
            completion(true)
        }
    }
    
    func delete(contact: Contact, completion: @escaping (Bool) -> Void) {
        deleteContactFromCloudKit(contact: contact) { (_, error) in
            if let error = error {
                print("Error deleting contact: \(error.localizedDescription)")
                completion(false); return
            }
            guard let index = self.contacts.index(of: contact) else { completion(false); return }
            self.contacts.remove(at: index)
            completion(true)
        }
    }
    
    func update(contact: Contact,
                withName name: String,
                phoneNumber: String?,
                emailAddress: String?,
                completion: @escaping (Bool) -> Void = { _ in }) {
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.emailAddress = emailAddress
        
        let record = CKRecord(contact: contact)
        updateContactInCloudKit(record: record, completion: completion)
    }
    
    
    //MARK: - CloudKit Methods
    func fetchAllContacts(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Contact.typeKey, predicate: predicate)
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching contacts from CloudKit \(error.localizedDescription)")
                completion(false); return
            }
            
            guard let records = records else { completion(false); return }
            
            let contacts = records.compactMap { Contact(record: $0) }
            self.contacts = contacts
            completion(true)
        }
    }
    
    func saveContactToCloudKit(contact: Contact, completion: @escaping (CKRecord?, Error?) -> Void) {
        let record = CKRecord(contact: contact)
        privateDatabase.save(record, completionHandler: completion)
    }
    
    func deleteContactFromCloudKit(contact: Contact, completion: @escaping (CKRecordID?, Error?) -> Void) {
        let record = CKRecord(contact: contact)
        privateDatabase.delete(withRecordID: record.recordID, completionHandler: completion)
    }
    
    func updateContactInCloudKit(record: CKRecord, completion: @escaping (Bool) -> Void) {
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        operation.completionBlock = { completion(true) }
        privateDatabase.add(operation)
    }
}
