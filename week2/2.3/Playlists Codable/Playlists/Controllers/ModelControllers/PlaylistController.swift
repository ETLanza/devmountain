//
//  PlaylistController.swift
//  Playlists
//
//  Created by Joe Lucero on 7/4/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import Foundation
import CoreData

class PlaylistController {
    
    // create a shared instance of PlaylistController
    static let shared = PlaylistController()
    
    // create an array of playlists for that shared instance
    var playlists: [Playlist] {
        let moc = CoreDataStack.managedObjectContext
        
        let fetchRequest: NSFetchRequest<Playlist> = Playlist.fetchRequest()
        
        let results = try? moc.fetch(fetchRequest)
        
        return results ?? []
    }
    
    func addPlaylistWith(title: String) {
        _ = Playlist(title: title)
        CoreDataManager.saveToPersistentStore()
    }
    
    func delete(playlist: Playlist) {
        CoreDataManager.delete(object: playlist)
    }
}

















