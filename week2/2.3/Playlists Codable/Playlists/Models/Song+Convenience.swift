//
//  Song+Convenience.swift
//  Playlists
//
//  Created by Eric Lanza on 7/11/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import Foundation
import CoreData

extension Song {
    convenience init(title: String, artist: String, playlist: Playlist,
                     context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.title = title
        self.artist = artist
        self.playlist = playlist
    }
}
