//
//  Pokemon.swift
//  PokeDex
//
//  Created by Eric Lanza on 7/17/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let weight: Int
    let id: Int
    let sprites: Sprite
}

struct Sprite: Codable {
    let pokemonImageURLAsString: String
    
    enum CodingKeys: String, CodingKey {
        case pokemonImageURLAsString = "front_default"
    }
}
