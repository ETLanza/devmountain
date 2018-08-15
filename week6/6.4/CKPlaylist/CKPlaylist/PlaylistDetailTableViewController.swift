//
//  PlaylistDetailTableViewController.swift
//  CKPlaylist
//
//  Created by Eric Lanza on 8/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PlaylistDetailTableViewController: UITableViewController, UITextFieldDelegate{
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    
    var playlist: Playlist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let playlist = playlist else { return }
        PlaylistController.shared.fetchSongsFor(playlist: playlist) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
            let artist = artistTextField.text, !artist.isEmpty,
            let playlist = playlist else { return }
        
        PlaylistController.shared.addSong(toPlaylist: playlist, withTitle: title, andArtist: artist) { (true) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.titleTextField.text = ""
                self.artistTextField.text = ""
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            artistTextField.becomeFirstResponder()
        } else {
            artistTextField.resignFirstResponder()
            saveButtonTapped(self)
        }
        return true
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist?.songs.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        let song = playlist?.songs[indexPath.row]
        
        cell.textLabel?.text = song?.title
        cell.detailTextLabel?.text = song?.artist
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlist else { return }
            let song = playlist.songs[indexPath.row]
            PlaylistController.shared.delete(song: song, fromPlaylist: playlist) { (success) in
                if success {
                    DispatchQueue.main.async {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            }
        }
    }
}
