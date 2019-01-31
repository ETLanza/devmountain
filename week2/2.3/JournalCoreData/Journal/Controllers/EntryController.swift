//
//  EntryController.swift
//  Journal
//
//  Created by Eric Lanza on 7/5/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData


class EntryController {
    
    // MARK: - Singleton
    static let shared = EntryController()
    
    //MARK: - Properties
    // Source of Truth
    var entries: [Entry] {
        let request: NSFetchRequest<Entry> = Entry.fetchRequest()
        do {
            return try CoreDataStack.context.fetch(request)
        } catch {
            print("Error fetching entries: \(error)")
            return []
        }
    }
    
    //MARK: - CRUD Methods
    func createEntryWith(title: String, bodyText: String) {
        Entry(title: title, bodyText: bodyText)
        saveToPersistentStore()
    }
    
    func update(entry: Entry, withNewTitle title: String, andNewBody bodyText: String) {
        entry.title = title
        entry.bodyText = bodyText
        saveToPersistentStore()
    }
    
    func remove(entry: Entry) {
        if let moc = entry.managedObjectContext {
            moc.delete(entry)
            saveToPersistentStore()
        }
    }
    
    //MARK: - Persistence
     private func saveToPersistentStore() {
        if CoreDataStack.context.hasChanges {
            try? CoreDataStack.context.save()
        }
    }
}
