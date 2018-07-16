//
//  SongController.swift
//  Playlists
//
//  Created by Joe Lucero on 7/4/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

class SongController {
    
   static func createSongWith(title: String, artist: String, playlist: Playlist) {
    _ = Song(title: title, artist: artist, playlist: playlist)
    CoreDataManager.saveToPersistentStore()
   }
    
    static func delete(song: Song) {
        CoreDataManager.delete(object: song)
    }
}
