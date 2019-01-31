//
//  PlaylistController.swift
//  Playlists
//
//  Created by Eric Lanza on 7/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class PlaylistController: Codable {
    
    static let shared = PlaylistController()
    
    var playlists = [Playlist]()
    
     static func addPlaylistWith(title: String) {
        let newPlaylist = Playlist(title: title)
        PlaylistController.shared.playlists.append(newPlaylist)
        saveToPersistentStore()
    }
    
    static func deletePlaylist(_ playlist: Playlist) {
        guard let indexOfPlaylist = PlaylistController.shared.playlists.index(of: playlist) else { return }
        PlaylistController.shared.playlists.remove(at: indexOfPlaylist)
        saveToPersistentStore()
    }
    
    static func addSong(_ song: Song, to playlist: Playlist) {
        guard let indexOfPlaylist = PlaylistController.shared.playlists.index(of: playlist) else { return }
        PlaylistController.shared.playlists[indexOfPlaylist].songs.append(song)
        saveToPersistentStore()
    }
    
    static func deleteSong(_ song: Song, from playlist: Playlist) {
        guard let indexOfSong = playlist.songs.index(of: song) else { return }
        playlist.songs.remove(at: indexOfSong)
        saveToPersistentStore()
    }
    
    func fileURL() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths)
        let documentDirectory = paths[0]
        
        let playlistLocation = "playlist.json"
        
        let url = documentDirectory.appendingPathComponent(playlistLocation)
        print(url.absoluteString)
        
        return url
    }
    
     static func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(PlaylistController.shared.playlists)
            try data.write(to: PlaylistController.shared.fileURL())
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
    
     static func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: PlaylistController.shared.fileURL())
            let decodedPlaylists = try jsonDecoder.decode([Playlist].self, from: data)
            PlaylistController.shared.playlists = decodedPlaylists
        } catch let error {
            print("Error loading from persistent store: \(error.localizedDescription)")
        }
    }
    
}














