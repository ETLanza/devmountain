//
//  NoteController.swift
//  Notes
//
//  Created by Eric Lanza on 7/6/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class NoteController: Codable {
    
    static let shared = NoteController()
    
    var notes = [Note]()
    
    //MARK: - CRUD Methods
    func addNote(_ note: Note) {
        notes.append(note)
        saveToPersistentStore()
    }
    
    func updateNote(_ note: Note, withBodyText bodyText: String) {
        note.bodyText = bodyText
        saveToPersistentStore()
    }
    
    func deleteNote(_ note: Note) {
        guard let indexOfNote = NoteController.shared.notes.index(of: note) else { return }
        notes.remove(at: indexOfNote)
        saveToPersistentStore()
    }
    
    //MARK: - Persistance Methods
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "notes.json"
        let url = documentDirectory.appendingPathComponent(fileName)
        return url
    }
    
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(notes)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedNotes = try jsonDecoder.decode([Note].self, from: data)
            notes = decodedNotes
        } catch let error {
            print("Error loading from persistent store: \(error.localizedDescription)")
        }
    }
}
