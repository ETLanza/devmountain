//
//  Song+Convenience.swift
//  PlaylistCoreData
//
//  Created by Eric Lanza on 7/11/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

extension Song {
    convenience init(title: String, artist: String, playlist: Playlist,
        context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.artist = artist
        self.playlist = playlist
    }
}
