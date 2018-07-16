//
//  EntryController.swift
//  JournalCoreData
//
//  Created by Eric Lanza on 7/12/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    static var entries: [Entry] {
        let moc = CoreDataStack.managedObjectContext
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        let results = try? moc.fetch(fetchRequest)
        return results ?? []
    }
    
    //MARK: - CRUD Functions
    static func createEntryWith(title: String, bodyText: String, isGoodDay: Bool) {
        let _ = Entry(title: title, bodyText: bodyText, isGoodDay: isGoodDay)
        saveToPersistentStore()
    }
    
    static func update(entry: Entry, newTitle: String, newBodyText: String, newIsGoodDay: Bool ){
        entry.title = newTitle
        entry.bodyText = newBodyText
        entry.isGoodDay = newIsGoodDay
        saveToPersistentStore()
    }
    
    static func delete(entry: Entry){
        entry.managedObjectContext?.delete(entry)
        saveToPersistentStore()
    }
    
    private static func saveToPersistentStore() {
        if CoreDataStack.managedObjectContext.hasChanges {
            try?CoreDataStack.managedObjectContext.save()
        }
    }
}
