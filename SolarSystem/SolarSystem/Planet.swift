//
//  Planet.swift
//  SolarSystem
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class Planet {
    var name: String
    var image: UIImage
    var diameter: Double
    var distanceToSun: Double
    var dayLength: Int
    
    init(name: String, image: UIImage, diameter: Double, distanceToSun: Double, dayLength: Int) {
        self.name = name
        self.image = image
        self.diameter = diameter
        self.distanceToSun = distanceToSun
        self.dayLength = dayLength
    }
}
