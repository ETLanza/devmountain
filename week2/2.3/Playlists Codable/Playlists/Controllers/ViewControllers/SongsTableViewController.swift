//
//  SongsTableViewController.swift
//  Playlists
//
//  Created by Joe Lucero on 7/4/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

class SongsTableViewController: UITableViewController {
    
    var playlist: Playlist!
    
    @IBOutlet weak var songTF: UITextField!
    @IBOutlet weak var artistTF: UITextField!
    
    @IBAction func addSong(_ sender: UIBarButtonItem) {
        // check to make sure there is text
        guard let song = songTF.text,
            song != "",
            let artist = artistTF.text,
            !artist.isEmpty else {
                print("Someone forgot to add text to the text fields")
                return
        }
        
        SongController.createSongWith(title: song, artist: artist, playlist: playlist)
        
        // delete the text from the text fields
        songTF.text = ""
        artistTF.text = ""
        
        // reload the tableview
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.songs?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create/recycle a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        
        // Configure the cell...
        guard let songs = playlist.songs?.allObjects as? [Song] else { return UITableViewCell() }
        let songForCell = songs[indexPath.row]
        cell.textLabel?.text = songForCell.title
        cell.detailTextLabel?.text = songForCell.artist
        
        
        // return a cell
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let songs = playlist.songs?.allObjects as? [Song] else { return  }
            let songToDelete = songs[indexPath.row]
            SongController.delete(song: songToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
