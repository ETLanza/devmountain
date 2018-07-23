//
//  CharacterController.swift
//  StarWars
//
//  Created by Eric Lanza on 7/19/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class StarWarsCharacterController: Codable {
    
    static let shared = StarWarsCharacterController()
    
    var characters: [StarWarsCharacter] = []
    
    static let baseURl = URL(string: "https://starwarstest16.herokuapp.com/api/characters")
    
    static func getCharacters(completion: @escaping ((Bool) -> Void)) {
        
        guard let url = baseURl else { completion(false); return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error getting characters: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let data = data else { completion(false); return }
            
//            guard let dictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String : [[String:Any]]]
//                else {
//                    print("Error with JSON Serilization")
//                    completion(false)
//                    return }
            
            let jsonDecoder = JSONDecoder()
            let toplevelJSON = try! jsonDecoder.decode(TopLevelJSON.self, from: data)
            
            
//            var characters: [StarWarsCharacter] = []
//            guard let starWarCharDict = dictionary["individuals"] else { completion(false); return}
//
//            for dict in starWarCharDict {
//                if let newCharacter = StarWarsCharacter(dictionary: dict) {
//                    characters.append(newCharacter)
//
//                }
//            }
            
            StarWarsCharacterController.shared.characters = toplevelJSON.individuals
            completion(true)
        }
        dataTask.resume()
    }
}

//MARK: - Persistence
extension StarWarsCharacterController {
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "characters.json"
        let url = documentDirectory.appendingPathComponent(fileName)
        return url
    }
    
    static func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(StarWarsCharacterController.shared.characters)
            try data.write(to: StarWarsCharacterController.shared.fileURL())
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
    
    static func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: StarWarsCharacterController.shared.fileURL())
            let decodedCharacters = try jsonDecoder.decode([StarWarsCharacter].self, from: data)
            StarWarsCharacterController.shared.characters = decodedCharacters
        } catch let error {
            print("Error loading from persistent store: \(error.localizedDescription)")
        }
    }
}
