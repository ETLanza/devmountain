//
//  PlaylistTableViewController.swift
//  CKPlaylist
//
//  Created by Eric Lanza on 8/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlaylistController.shared.fetchAllPlaylist { (success) in
            if success {
                for playlist in PlaylistController.shared.playlists {
                    PlaylistController.shared.fetchSongsFor(playlist: playlist, completion: { (success) in
                        if success {
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    })
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        titleTextField.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let title = titleTextField.text, !title.isEmpty else { return false }
        PlaylistController.shared.createPlaylistWith(title: title) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.titleTextField.isHidden = true
                    self.titleTextField.text = ""
                    self.tableView.reloadData()
                }
            }
        }
        return true
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        
        cell.textLabel?.text = playlist.title
        cell.detailTextLabel?.text = "\(playlist.songs.count) songs"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.delete(playlist: playlist) { (success) in
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPlaylistSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? PlaylistDetailTableViewController else { return }
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            destinationVC.playlist = playlist
            destinationVC.title = playlist.title
        }
    }
}
