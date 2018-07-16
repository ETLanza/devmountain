//
//  PlaylistsTableViewController.swift
//  Playlists
//
//  Created by Joe Lucero on 7/4/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

class PlaylistsTableViewController: UITableViewController {
    
    let playlistController = PlaylistController()
    
    @IBOutlet weak var playlistTF: UITextField!
    
    @IBAction func playlistAdded(_ sender: UIBarButtonItem) {
        guard let title = playlistTF.text, !title.isEmpty else {
            print("No title for the playlist")
            return
        }
        
        PlaylistController.shared.addPlaylistWith(title: title)
        playlistTF.text = ""
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create/recycle a cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath)
        
        // Configure the cell...
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        cell.textLabel?.text = playlist.title
        guard let songs = playlist.songs?.allObjects as? [Song]else { return UITableViewCell() }
        cell.detailTextLabel?.text = "\(songs.count) songs"
        
        // return the cell...
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // update the model
            let playlistToDelete = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.delete(playlist: playlistToDelete)
            
            // update the view
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSongsVC" {
            guard let destinationVC = segue.destination as? SongsTableViewController else {
                return
            }
            
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
                return
            }
            
            let selectedPlaylist = PlaylistController.shared.playlists[selectedIndexPath.row]
            
            destinationVC.playlist = selectedPlaylist
            destinationVC.title = selectedPlaylist.title
        }
    }
}
