//
//  Playlist.swift
//  Playlists
//
//  Created by Eric Lanza on 7/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class Playlist: Equatable, Codable {

    let title: String
    var songs = [Song]()
    
    init(title: String) {
        self.title = title
        self.songs = []
    }
    
    static func ==(lhs: Playlist, rhs: Playlist) -> Bool {
        return (lhs.title == rhs.title && lhs.songs == rhs.songs)
    }
    
}
