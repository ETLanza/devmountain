//
//  PlanetTableViewController.swift
//  SolarSystem
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PlanetTableViewController: UITableViewController {
    
    var planets = PlanetController.planets
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetTableViewCell", for: indexPath) as? PlanetTableViewCell else { fatalError() }
        let cellsPlanet = planets[indexPath.row]
        cell.planetNameLabel.text = cellsPlanet.name
        cell.planetImageView.image = cellsPlanet.image
        return cell
    }
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerImage: UIImage = #imageLiteral(resourceName: "solarsystem")
        let headerView = UIImageView(image: headerImage)
        return headerView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let destinationVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow
                else { return }
            destinationVC.planet = planets[indexPath.row]
            
        }
    }
}
