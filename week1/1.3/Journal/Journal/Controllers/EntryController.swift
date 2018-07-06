//
//  EntryController.swift
//  Journal
//
//  Created by Eric Lanza on 7/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class EntryController: Codable {
    
    static let shared = EntryController()
    
    var entries = [Entry]()
    
//    static func addEntryWith(title: String, text: String) {
//        let entry = Entry(title: title, bodyText: text)
//        EntryController.shared.entries.append(entry)
//        JournalController.saveToPersistentStore()
//    }
//    
//    static func remove(entry: Entry) {
//        guard let index = EntryController.shared.entries.index(of: entry) else { return }
//        EntryController.shared.entries.remove(at: index)
//        JournalController.saveToPersistentStore()
//    }
    
    static func update(entry: Entry, withNewTitle title: String, andNewText text: String) {
        guard let index = EntryController.shared.entries.index(of: entry) else { return }
        EntryController.shared.entries[index].title = title
        EntryController.shared.entries[index].bodyText = text
        JournalController.saveToPersistentStore()
    }
}
