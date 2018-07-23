//
//  Pokemon.swift
//  PokeDex2
//
//  Created by Eric Lanza on 7/17/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class Pokemon: Codable {
    private let nameKey = "name"
    private let weightKey = "weight"
    private let idKey = "id"
    private let spritesKey = "sprites"
    private let imageKey = "front_default"
    
    let name: String
    let weight: Int
    let id: Int
    let imageURLAsString: String
    
    init?(pokeDictionary: [String: Any]) {
        guard let name = pokeDictionary[nameKey] as? String,
        let weight = pokeDictionary[weightKey] as? Int,
        let id = pokeDictionary[idKey] as? Int,
        let spritesDictionary = pokeDictionary[spritesKey] as? [String:Any],
            let image = spritesDictionary[imageKey] as? String else { return nil }
        
        self.name = name
        self.weight = weight
        self.id = id
        self.imageURLAsString = image
        
    }
}
