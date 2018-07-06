//
//  Song.swift
//  Playlists
//
//  Created by Eric Lanza on 7/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class Song: Equatable, Codable {
    
    let title: String
    let artist: String
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
    
    static func == (lhs: Song, rhs: Song) -> Bool {
        return (lhs.title == rhs.title && lhs.artist == rhs.artist)
    }
    
    
    
}
