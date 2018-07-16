//
//  PlaylistController.swift
//  PlaylistCoreData
//
//  Created by Eric Lanza on 7/11/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

class PlaylistController {
    
    //MARK: - Shared Instance
    static let shared = PlaylistController()
    
    //MARK: - Array of playlist
    var playlists: [Playlist] {
        let moc = CoreDataStack.context
        
        let fetchRequest: NSFetchRequest<Playlist> = Playlist.fetchRequest()
        
        let results = try? moc.fetch(fetchRequest)
        
        return results ?? []
    }
    
    //MARK: - CRUD Functions
    func createPlaylistWith(name: String) {
        _ = Playlist(name: name)
        saveToPersistentStore()
    }
    
    func delete(playlist: Playlist) {
        let moc = CoreDataStack.context
        moc.delete(playlist)
        saveToPersistentStore()
    }
    
    //MARK: - Private Persistent Save
    private func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
}
