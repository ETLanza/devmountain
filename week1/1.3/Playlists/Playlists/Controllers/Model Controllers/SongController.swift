//
//  SongController.swift
//  Playlists
//
//  Created by Eric Lanza on 7/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class SongController {
    
    static let shared = SongController()
    
    var songs = [Song]()
    
    static func createSongWith(title: String,
                               artist: String,
                               playlist: Playlist) {
        
        let newSong = Song(title: title, artist: artist)
        
        PlaylistController.addSong(newSong, to: playlist)
    }
}
