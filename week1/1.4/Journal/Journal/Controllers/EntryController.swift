//
//  EntryController.swift
//  Journal
//
//  Created by Eric Lanza on 7/5/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class EntryController {
    
    static let shared = EntryController()
    
    var entries = [Entry]()
    
    //MARK: - CRUD Methods
    
    func addEntryWith(title: String, bodyText: String) {
        entries.append(Entry.init(title: title, bodyText: bodyText))
        saveToPersistentStore()
    }
    
    func updateEntry(_ entry: Entry, withNewTitle title: String, andNewBody bodyText: String) {
        guard let index = entries.index(of: entry) else { return }
        entries[index].title = title
        entries[index].bodyText = bodyText
        saveToPersistentStore()
    }
    
    func removeEntry(_ entry: Entry) {
        guard let index = entries.index(of: entry) else { return }
        entries.remove(at: index)
        saveToPersistentStore()
    }
    
    //MARK: - Persistance
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let journalLocation = "journal.json"
        let url = documentDirectory.appendingPathComponent(journalLocation)
        return url
    }
    
     func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(entries)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
     func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedEntries = try jsonDecoder.decode([Entry].self, from: data)
            entries = decodedEntries
        } catch let error {
            print("Error loading from persistent store: \(error.localizedDescription)")
        }
    }
    
    
}
