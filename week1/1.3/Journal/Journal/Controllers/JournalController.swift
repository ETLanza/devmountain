//
//  JournalController.swift
//  Journal
//
//  Created by Eric Lanza on 7/5/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class JournalController: Codable {
    
    static let shared = JournalController()
    
    var journals = [Journal]()
    
    static func addJournalWith(title: String) {
        let journal = Journal(title: title)
        JournalController.shared.journals.append(journal)
        saveToPersistentStore()
    }
    
    static func deleteJournal(_ journal: Journal) {
        guard let index = JournalController.shared.journals.index(of: journal) else { return }
        JournalController.shared.journals.remove(at: index)
        saveToPersistentStore()
    }
    
    static func updateJournal(_ journal: Journal, withNewTitle title: String){
        guard let index = JournalController.shared.journals.index(of: journal) else { return }
        JournalController.shared.journals[index].title = title
        saveToPersistentStore()
    }
    
    static func addEntry(_ entry: Entry, to journal: Journal) {
        guard let indexOfJournal = JournalController.shared.journals.index(of: journal) else { return }
        JournalController.shared.journals[indexOfJournal].entries.append(entry)
        saveToPersistentStore()
    }
    
    static func deleteEntry(_ entry: Entry, from journal: Journal) {
        guard let indexOfEntry = journal.entries.index(of: entry) else { return }
        journal.entries.remove(at: indexOfEntry)
        saveToPersistentStore()
    }
    
    
    //MARK: - Persistance Methods
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let playlistLocation = "journal.json"
        let url = documentDirectory.appendingPathComponent(playlistLocation)
        return url
    }
    
    static func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(JournalController.shared.journals)
            try data.write(to: JournalController.shared.fileURL())
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
    
    static func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: JournalController.shared.fileURL())
            let decodedData = try jsonDecoder.decode([Journal].self, from: data)
            JournalController.shared.journals = decodedData
        } catch let error {
            print("Error loading from persistent store: \(error.localizedDescription)")
        }
    }
}
