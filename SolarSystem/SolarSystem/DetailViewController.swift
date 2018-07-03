//
//  DetailViewController.swift
//  SolarSystem
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var diameterLabel: UILabel!
    @IBOutlet var dayLengthLabel: UILabel!
    @IBOutlet var distanceFromSunLabel: UILabel!
    @IBOutlet var planetImageView: UIImageView!
    var planet: Planet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
    }
    
    func updateView() {
        if let boundPlanet = planet {
        diameterLabel.text = "Diameter: \(boundPlanet.diameter) miles"
        dayLengthLabel.text = "Day Length: \(boundPlanet.dayLength) hours"
        distanceFromSunLabel.text = "Distance to the sun: \(boundPlanet.distanceToSun) miles"
        planetImageView.image = boundPlanet.image
        title = boundPlanet.name
        }
    }
}

