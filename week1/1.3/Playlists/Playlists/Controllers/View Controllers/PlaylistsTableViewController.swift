//
//  PlaylistsTableViewController.swift
//  Playlists
//
//  Created by Eric Lanza on 7/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PlaylistsTableViewController: UITableViewController {

    @IBOutlet weak var playlistTF: UITextField!
    @IBAction func addPlaylistButton(_ sender: UIBarButtonItem) {
        guard let playlist = playlistTF.text , playlist != "" else { return }
        PlaylistController.addPlaylistWith(title: playlist)
    
        playlistTF.text = ""
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PlaylistController.shared.playlists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        
        cell.textLabel?.text = playlist.title
        cell.detailTextLabel?.text = "\(playlist.songs.count) songs"
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.deletePlaylist(playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tappedIndexPath = tableView.indexPathForSelectedRow else { return }
        let playlist = PlaylistController.shared.playlists[tappedIndexPath.row]
        if let destinationVC = segue.destination as? SongsTableViewController {
            destinationVC.playlist = playlist
            destinationVC.title = playlist.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlaylistController.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
