//
//  PersonTableViewController.swift
//  ClubMembers
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {
    
    let personController = PersonController()
    let clubMember = ClubMembers()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = personController.createPersonWith(firstName: "John", lastName: "Doe", age: 27)
        let steve = personController.createPersonWith(firstName: "Steve", lastName: "Jobs", age: 63)
        _ = personController.createPersonWith(firstName: "Derek", lastName: "Pants", age: 27)
        _ = personController.createPersonWith(firstName: "Mavrick", lastName: "Snow", age: 27)

        _ = personController.createPersonWith(firstName: "Ellaria", lastName: "Sands", age: 27)
        clubMember.addClubMember(steve)
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personController.persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let person = personController.persons[indexPath.row]
        cell.textLabel?.text = "\(person.firstName) \(person.lastName)"
        
        if checkIfClubMember(person) {
            cell.detailTextLabel?.text = "Club Member"
        } else {
            cell.detailTextLabel?.text = "Not a Club Member"
        }
        
        
        // Configure the cell...
        
        return cell
    }
    
    
    func checkIfClubMember(_ person: Person) -> Bool {
       return clubMember.clubMembers.contains(person)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    @IBOutlet weak var swapListButton: UIBarButtonItem!
    
    func deleteRows() {
        
    }
    
    @IBAction func swapList(_ sender: UIBarButtonItem) {
        for person in personController.persons {
            if !checkIfClubMember(person) {
                for cell in tableView.visibleCells {
                    if cell.textLabel?.text == "\(person.firstName) \(person.lastName)" {
                        let indexPaths = [tableView.indexPath(for: cell)!]
                        personController.persons.remove(at: tableView.indexPath(for: cell)!.row)
                        tableView.deleteRows(at: indexPaths, with: .fade )
                        swapListButton.title = ""
                        title = "Club Members"
                    }
                }
            }
        }
    }
}
