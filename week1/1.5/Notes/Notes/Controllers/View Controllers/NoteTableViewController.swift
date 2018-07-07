//
//  NoteTableViewController.swift
//  Notes
//
//  Created by Eric Lanza on 7/6/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {
    
    //MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredNotes: [Note] = []
    
    //MARK: IBOutlets
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    //MARK: IBActions
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if  tableView.isEditing {
            tableView.setEditing(false, animated: true);
            editBarButton.title = "Edit";
            editBarButton.style = UIBarButtonItemStyle.plain;
        } else {
            tableView.setEditing(true, animated: true);
            editBarButton.style = UIBarButtonItemStyle.done
            editBarButton.title = "Done";
            editBarButton.style =  UIBarButtonItemStyle.done;
        }
    }
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NoteController.shared.loadFromPersistentStore()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search notes"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredNotes.count
        }
        return NoteController.shared.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        let note = findCorrectNote(withIndex: indexPath)
        cell.textLabel?.text = note.bodyText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let note = findCorrectNote(withIndex: indexPath)
        if editingStyle == .delete {
            if isFiltering() {
                NoteController.shared.deleteNote(note)
                searchController.searchResultsUpdater?.updateSearchResults(for: searchController)
            } else {
                NoteController.shared.deleteNote(note)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let note: Note = NoteController.shared.notes[sourceIndexPath.row]
        NoteController.shared.deleteNote(note)
        NoteController.shared.addNote(note)
    }
    
    // MARK: - Private instance methods
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredNotes = NoteController.shared.notes.filter({( note : Note) -> Bool in
            return note.bodyText.lowercased().contains(searchText.lowercased())
            
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func findCorrectNote(withIndex index: IndexPath) -> Note {
        let note: Note
        if isFiltering() {
            note = filteredNotes[index.row]
        } else {
            note = NoteController.shared.notes[index.row]
        }
        return note
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? NoteDetailViewController else { return }
        if segue.identifier == "editNoteSegue" {
            guard let indexOfNote = tableView.indexPathForSelectedRow else { return }
            let note = findCorrectNote(withIndex: indexOfNote)
            destinationVC.note = note
        }
    }
}

extension NoteTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
