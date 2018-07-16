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
    
    static let shared = EntryController()
    
    //MARK: - CRUD Methods
    func add(entry: Entry) {
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
        do{
            try CoreDataStack.context.save()
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }

    //MARK: - Properties
    var entries: [Entry] {
        let request: NSFetchRequest<Entry> = Entry.fetchRequest()
        do {
            return try CoreDataStack.context.fetch(request)
        } catch {
            print("Error fetching entries: \(error)")
            return []
        }
    }
}
