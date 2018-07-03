//
//  WeekdayTableViewController.swift
//  DaysOfTheWeek
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class WeekdayTableViewController: UITableViewController {
    
    var daysOfTheWeek = ["Monday", "Tuesday", "Wednesday",
                         "Thursday", "Friday", "Saturday", "Sunday",
                         "Karl is awesome day", "Global warming day"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfTheWeek.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dayCell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        // Create the cell
        
        // Set the cell in the correct location
        
        let day = daysOfTheWeek[indexPath.row]
        let cellNumber = indexPath.row
        
        // Add the days value
        
        dayCell.textLabel?.text = day
        dayCell.detailTextLabel?.text = "\(cellNumber)"
        
        return dayCell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToVC" {
            guard let destinationVC = segue.destination as? DetailViewController else { return }
            guard let selectedDay = sender as? UITableViewCell else { return }
            destinationVC.title = selectedDay.textLabel?.text
        }
    }
}
