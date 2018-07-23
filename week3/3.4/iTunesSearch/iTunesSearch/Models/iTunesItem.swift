//
//  iTunesItem.swift
//  iTunesSearch
//
//  Created by Eric Lanza on 7/19/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Codable {
    let results: [iTunesItem]
}

struct iTunesItem: Codable {
    let artistName: String
    let albumName: String
    let songName: String
    let imageURLAsString: String
    
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case albumName = "collectionName"
        case songName = "trackName"
        case imageURLAsString = "artworkUrl100"
    }
}
