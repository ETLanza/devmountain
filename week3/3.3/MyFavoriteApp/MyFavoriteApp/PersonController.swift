//
//  PersonController.swift
//  MyFavoriteApp
//
//  Created by Eric Lanza on 7/17/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class PersonController {
    
    //MARK: - Shared Instanced
    static let shared = PersonController()
    
    //MARK: - Properties
    var people: [Person] = []
    
    //MARK: - BaseURL
    static let baseURL = URL(string: "https://myfavoriteapp-6369c.firebaseio.com")
    
    static func getPeople(completion: @escaping ((Bool) -> Void)) {
        
        let fullURL = baseURL?.appendingPathComponent("people")
        
        guard let fullURLAsJson = fullURL?.appendingPathExtension("json") else { completion(false) ; return }
        
        var urlRequest = URLRequest(url: fullURLAsJson)
        urlRequest.httpMethod = "GET"
        urlRequest.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print("Error getting people form the web: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let data = data else {
                print("There was no data")
                completion(false)
                return
            }
            
            guard let jsonDictionaries = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String : [String: Any]] else {
                print("JSON Data was not converted into a format we expected")
                completion(false)
                return }
            
            var people: [Person] = []
            for dict in jsonDictionaries {
                if let newPerson = Person(dict: dict.value) {
                    people.append(newPerson)
                }
            }
            
            PersonController.shared.people = people
            completion(true)
        }
        dataTask.resume()
    }
    
    static func postPerson(name: String, favoriteApp: String, completion: @escaping ((Bool) -> Void)) {
        
        guard let fullURL = baseURL?.appendingPathComponent("people").appendingPathExtension("json") else {
            print("Error getting the right URL")
            completion(false)
            return
        }
        
        let newPerson = Person(name: name, favoriteApp: favoriteApp)
        
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = newPerson.asData
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print("Error posting to Firebase: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard data != nil else {
                print("No data was received")
                completion(false)
                return
            }
            
            PersonController.shared.people.append(newPerson)
            completion(true)
        }
        dataTask.resume()
    }
    
}
