//
//  PlanetController.swift
//  SolarSystem
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class PlanetController {
    static var planets: [Planet] {
        let earth = Planet(name: "Earth", image: #imageLiteral(resourceName: "Earth"), diameter: 7917.5, distanceToSun: 92_960_000, dayLength: 24)
        
        let mercury = Planet(name: "Mercury", image: #imageLiteral(resourceName: "Mercury"), diameter: 3032, distanceToSun: 35_980_000, dayLength: 1408)
        
        let mars = Planet(name: "Mars", image: #imageLiteral(resourceName: "Mars"), diameter: 4212, distanceToSun: 141_600_000, dayLength: 25)
        
        let jupiter = Planet(name: "Jupiter", image: #imageLiteral(resourceName: "Jupiter"), diameter: 86881.4, distanceToSun: 483_800_000, dayLength: 10)
        
        let neptune = Planet(name: "Neptune", image: #imageLiteral(resourceName: "Neptune"), diameter: 30599, distanceToSun: 2_793_000_000, dayLength: 16)
        
        let pluto = Planet(name: "Pluto", image: #imageLiteral(resourceName: "Pluto"), diameter: 1477, distanceToSun: 3_670_000_000, dayLength: 154)
        
        let venus = Planet(name: "Venus", image: #imageLiteral(resourceName: "Venus"), diameter: 7520.8, distanceToSun: 67_240_000, dayLength: 5832)
        
        let uranus = Planet(name: "Uranus", image: #imageLiteral(resourceName: "Uranus"), diameter: 31518, distanceToSun: 1_784_000_000, dayLength: 17)
        
        let saturn = Planet(name: "Saturn", image: #imageLiteral(resourceName: "Saturn"), diameter: 72367.4, distanceToSun: 890_700_000, dayLength: 11)
        
        return [mercury, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto]
    }
}
