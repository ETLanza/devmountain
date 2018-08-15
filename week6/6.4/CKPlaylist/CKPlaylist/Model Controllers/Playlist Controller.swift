//
//  Playlist Controller.swift
//  CKPlaylist
//
//  Created by Eric Lanza on 8/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CloudKit

class PlaylistController {
    
    static let shared = PlaylistController()
    
    var playlists: [Playlist] = []
    
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    func createPlaylistWith(title: String, completion: @escaping (Bool) -> Void) {
        let playlist = Playlist(title: title)
        
        let record = CKRecord(playlist: playlist)
        
        publicDatabase.save(record) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false); return
            }
            self.playlists.append(playlist)
            completion(true)
        }
    }
    
    func delete(playlist: Playlist, completion: @escaping (Bool) -> Void ) {
        
        guard let recordID = playlist.recordID else { completion(false); return }
        
        publicDatabase.delete(withRecordID: recordID) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let index = PlaylistController.shared.playlists.index(of: playlist)
                else { completion(false); return }
            PlaylistController.shared.playlists.remove(at: index)
            completion(true)
        }
    }
    
    func addSong(toPlaylist playlist: Playlist,
                 withTitle title: String,
                 andArtist artist: String,
                 completion: @escaping (Bool) -> Void ) {
        
        guard let playlistRecordID = playlist.recordID else { completion(false); return }
        
        let reference = CKReference(recordID: playlistRecordID, action: .deleteSelf)
        let newSong = Song(title: title, artist: artist, playlistReference: reference)
        let record = CKRecord(song: newSong)
        
        publicDatabase.save(record) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false); return
            }
            playlist.songs.append(newSong)
            completion(true)
        }
    }
    
    func delete(song: Song, fromPlaylist playlist: Playlist, completion: @escaping (Bool) -> Void) {
        guard let index = playlist.songs.index(of: song),
        let recordID = song.recordID else { completion(false); return }
        
        publicDatabase.delete(withRecordID: recordID) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            playlist.songs.remove(at: index)
            completion(true)
        }
    }
    
    func fetchAllPlaylist(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Playlist.typeKey, predicate: predicate)
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false); return
            }
            
            guard let records = records else { completion(false); return}
            let playlists = records.compactMap { Playlist(record: $0) }
            
            self.playlists = playlists
            completion(true)
        }
    }
    
    func fetchSongsFor(playlist: Playlist, completion: @escaping (Bool) -> Void) {
        
        guard let playlistRecordID = playlist.recordID else { completion(false); return }
        let predicate = NSPredicate(format: "playlistReference == %@", playlistRecordID)
        let query = CKQuery(recordType: Song.typeKey, predicate: predicate)
        
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error)
                completion(false); return
            }
            
            guard let records = records else { completion(false); return }
            
            let songs = records.compactMap { Song(record: $0) }
            
            playlist.songs = songs
            completion(true)
        }
    }
}
