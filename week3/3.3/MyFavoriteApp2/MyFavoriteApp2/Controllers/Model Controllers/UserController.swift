//
//  UserController.swift
//  MyFavoriteApp2
//
//  Created by Eric Lanza on 7/18/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class UserController {
    
    static let shared = UserController()
    
    var users: [User] = []
    
    let baseURL = URL(string: "https://favoriteapp-375c6.firebaseio.com")
    
    func getUsers(completion: @escaping ((Bool) -> Void)) {
        guard let baseURL = baseURL else { completion(false ) ; return }
        
        let fullURL = baseURL.appendingPathComponent("users").appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = "GET"
        urlRequest.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Error with URL Request: \(error.localizedDescription)")
            }
            
            guard let data = data else { completion(false) ; return }
            
            do {
                let jsonDecoder = JSONDecoder()
                let dictOfUsers = try jsonDecoder.decode([String : User].self, from: data)
                var users: [User] =  []
                for (_, value) in dictOfUsers {
                    users.append(value)
                }
                self.users = users
                completion(true)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(false)
            }
        }
        dataTask.resume()
    }

    func addUser(name: String, favoriteApp: String, completion: @escaping ((Bool) -> Void)) {
        guard let baseURL = baseURL else { completion(false) ; return }
        let fullURL = baseURL.appendingPathComponent("users").appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = "POST"
        
        let newUser = User(name: name, favoriteApp: favoriteApp)
        
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(newUser)
            urlRequest.httpBody = data

        } catch {
            print("Error encoding user: \(error.localizedDescription)")
            completion(false)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print("Error with adding data task: \(error.localizedDescription)")
                completion(false)
                return
            }
            UserController.shared.users.append(newUser)
            completion(true)
        }
        dataTask.resume()
    }
}
