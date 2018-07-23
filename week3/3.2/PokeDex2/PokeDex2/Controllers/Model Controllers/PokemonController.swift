//
//  PokemonController.swift
//  PokeDex2
//
//  Created by Eric Lanza on 7/17/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class PokemonController {
    
    static let baseURL = URL(string: "http://pokeapi.co/api/v2/")
    
    static func getPokemon(nameOrID: String, completion: @escaping ((Pokemon?) -> Void)) {
        guard let baseURL = baseURL else { completion(nil) ; return }
        let getterEndpoint = baseURL.appendingPathComponent("pokemon").appendingPathComponent(nameOrID)
        print(getterEndpoint)
        var urlRequest = URLRequest(url: getterEndpoint)
        urlRequest.httpMethod = "get"
        urlRequest.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Error with URL Request: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let response = response {
                print("Response: \(response)")
            }
            
            guard let data = data else {
                print("Error unwrapping data")
                completion(nil)
                return
            }
            do {
                guard let pokemonDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] else {
                    completion(nil)
                    return
                }
                let pokemon = Pokemon(pokeDictionary: pokemonDictionary)
                completion(pokemon)
                return
            } catch {
                print("Error with JSONSerialization for pokemon: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
    
    static func getImage(for pokemon: Pokemon, completion: @escaping ((UIImage?) -> Void)) {
        guard let url = URL(string: pokemon.imageURLAsString) else { completion(nil) ; return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, reponse, error) in
            if let error = error {
                print("Error getting pokmon image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let reponse = reponse {
                print("Response: \(reponse)")
            }
            
            guard let data = data else { completion(nil) ; return }
            let image = UIImage(data: data)
            completion(image)
        }
        dataTask.resume()
        
    }
}


