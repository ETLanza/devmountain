//
//  PokemonController.swift
//  PokeDex
//
//  Created by Eric Lanza on 7/17/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PokemonController {
    
    static func searchForPokemon(by searchTerm: String, completion: @escaping ((Pokemon?) -> Void)) {
        let baseURLAsString = "https://pokeapi.co/api/v2/pokemon/"
        let urlAsString = baseURLAsString + searchTerm.lowercased()
        guard let url = URL(string: urlAsString) else {
            print("URL was not valid")
            completion(nil)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error with URL session: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No Data was found.")
                completion(nil)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(pokemon)
                return
            } catch {
                print("Error decoding Pokemon: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
    
    static func getPokemonImage(_ pokemon: Pokemon, completion: @escaping ((UIImage?) -> Void)) {
        
        guard let urlForImage = URL(string: pokemon.sprites.pokemonImageURLAsString) else {
            print("No URL for Pokemon image.")
            completion(nil)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlForImage) { (data, _, error) in
            if let error = error {
                print("Error getting pokemon image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data was received for Pokemon image")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        dataTask.resume()
    }
}
