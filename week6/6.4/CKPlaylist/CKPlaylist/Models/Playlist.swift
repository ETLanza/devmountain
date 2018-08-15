//
//  Playlist.swift
//  CKPlaylist
//
//  Created by Eric Lanza on 8/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

class Playlist: Equatable {
    
    static let typeKey = "Playlist"
    fileprivate static let titleKey = "title"

    var title: String
    var songs: [Song] = []
    var recordID: CKRecordID?
    
    init(title:String) {
        self.title = title
    }
    
    convenience init?(record: CKRecord) {
    guard let title = record[Playlist.titleKey] as? String else { return nil }
    
    self.init(title: title)
        recordID = record.recordID
    }
    
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.recordID == rhs.recordID
    }
}

extension CKRecord {
    convenience init(playlist: Playlist) {
        let recordID = playlist.recordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: Playlist.typeKey, recordID: recordID)
        self.setValue(playlist.title, forKey: Playlist.titleKey)
        playlist.recordID = recordID
    }
}
