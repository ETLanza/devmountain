//
//  DayOfTheWeekTableViewController.swift
//  DaysOfTheWeek2
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class DayOfTheWeekTableViewController: UITableViewController {
    
    let daysOfTheWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfTheWeek.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dayCell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        
        dayCell.detailTextLabel?.text = String(indexPath.row)
        dayCell.textLabel?.text = daysOfTheWeek[indexPath.row]
        
        return dayCell
    }
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let destinationVC = segue.destination as? DetailViewController,
                let selectedDay = sender as? UITableViewCell else { return }
            destinationVC.title = selectedDay.textLabel?.text
        }
    }
    
}
