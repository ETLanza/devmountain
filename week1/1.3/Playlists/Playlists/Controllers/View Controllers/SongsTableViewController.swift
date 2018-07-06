//
//  SongsTableViewController.swift
//  Playlists
//
//  Created by Eric Lanza on 7/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class SongsTableViewController: UITableViewController {
    
    var playlist: Playlist!
    
    @IBOutlet weak var songTF: UITextField!
    @IBOutlet weak var artistTF: UITextField!
    @IBAction func addSong(_ sender: UIBarButtonItem) {
        guard let song = songTF.text, song != "", let artist = artistTF.text, !artist.isEmpty else { return }
        
        SongController.createSongWith(title: song, artist: artist, playlist: playlist)
        
        songTF.text = ""
        artistTF.text = ""
        
//        PlaylistController.saveToPersistentStore()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        let songForCell = playlist.songs[indexPath.row]
        
        cell.textLabel?.text = songForCell.title
        cell.detailTextLabel?.text = songForCell.artist
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let songToDelete = playlist.songs[indexPath.row]
            PlaylistController.deleteSong(songToDelete, from: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

