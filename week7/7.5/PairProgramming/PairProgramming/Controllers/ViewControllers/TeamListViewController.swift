//
//  TeamListViewController.swift
//  PairProgramming
//
//  Created by Eric Lanza on 8/17/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class TeamListViewController: UIViewController, UITableViewDataSource {
    
    var teams: [String : [Person]] = [:]
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        createTeams()
        randomizeTeams()
    }
    
    //MARK: - IBActions
    @IBAction func randomizeButtonTapped(_ sender: UIButton) {
        randomizeTeams()
        tableView.reloadData()
    }
    
    //MARK: - Table View Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return teams.keys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let array = Array(teams.keys).sorted()
        let title = array[section]
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = Array(teams)[section].value.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let dictKey = Array(teams)[indexPath.section].key
        guard let values = teams[dictKey] else { return UITableViewCell()}
        let person = values[indexPath.row]
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    //MARK: - Helper Methods
    func createTeams() {
        guard let numberOfPeople = PersonController.shared.fetchedResultsController.fetchedObjects?.count else { return }
        let numberAsDouble = Double(numberOfPeople)
        var numberOfPairsAsDouble = numberAsDouble / 2
        numberOfPairsAsDouble.round(.up)
        let numberOfPairs = Int(numberOfPairsAsDouble)
        for i in 1...numberOfPairs {
            let name = "Team \(i)"
            teams[name] = []
        }
    }
    
    func randomizeTeams() {
        var people = PersonController.shared.fetchedResultsController.fetchedObjects
        for team in teams.keys {
            teams[team] = []
        }
        
        
        var count = 0
        for team in teams {
            count = 0
            while count < 2 {
                guard let peopleCounter = people?.count else { return }
                if peopleCounter == 0 { return }
                let randomIndex = Int(arc4random_uniform((UInt32(peopleCounter))))
                let person = people![randomIndex]
                teams[team.key]?.append(person)
                people?.remove(at: randomIndex)
                count += 1
            }
        }
    }
}
