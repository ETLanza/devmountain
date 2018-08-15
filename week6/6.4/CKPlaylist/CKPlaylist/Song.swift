//
//  Song.swift
//  CKPlaylist
//
//  Created by Eric Lanza on 8/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

class Song {
    
    static let typeKey = "Song"
    fileprivate static let titleKey = "title"
    fileprivate static let artistKey = "artist"
    fileprivate static let playlistReferenceKey = "playlistReference"
    
    var title: String
    var artist: String
    var recordID: CKRecordID?
    var playlistReference: CKReference?
    
    init(title: String, artist: String, playlistReference: CKReference) {
        self.title = title
        self.artist = artist
        self.playlistReference = playlistReference
    }
    
    convenience init?(record: CKRecord) {
        guard let title = record[Song.titleKey] as? String,
        let artist = record[Song.artistKey] as? String,
        let playlistReference = record[Song.playlistReferenceKey] as? CKReference else { return nil }
        self.init(title: title, artist: artist, playlistReference: playlistReference)
    }
}

extension CKRecord {
    convenience init(song: Song) {
        let recordID = song.recordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: Song.typeKey, recordID: recordID)
        setValue(song.title, forKey: Song.titleKey)
        setValue(song.artist, forKey: Song.artistKey)
        setValue(song.playlistReference, forKey: Song.playlistReferenceKey)
        song.recordID = recordID
    }
}
