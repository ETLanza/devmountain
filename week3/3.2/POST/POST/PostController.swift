//
//  PostController.swift
//  POST
//
//  Created by Eric Lanza on 7/16/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class PostController {
    var posts: [Post] = []
    
    static let baseURL = URL(string: "https://devmtn-posts.firebaseio.com/posts")!
    
    static let getterEndpoint = baseURL.appendingPathExtension("json")
    
    func fetchPosts(reset: Bool = true, completion: @escaping () -> ()){

        let queryEndInterval = reset ? Date().timeIntervalSince1970 : posts.last?.timestamp ?? Date().timeIntervalSince1970
        
        
        let urlParameters = [
            "orderBy": "\"timestamp\"",
            "endAt": "\(queryEndInterval)",
            "limitToLast": "15",
            ]
        
        let queryItems = urlParameters.compactMap( { URLQueryItem(name: $0.key, value: $0.value) } )
        
        var urlComponents = URLComponents(url: PostController.baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return }
        
        let getterEndpoint = url.appendingPathExtension("json")

        var request = URLRequest(url: getterEndpoint)
        request.httpBody = nil
        request.httpMethod = "GET"

        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("There was an error with the dataTask: \(error.localizedDescription)")
                completion()
                return
            }
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let postsDictionary = try decoder.decode([String:Post].self, from: data)
                let posts: [Post] = postsDictionary.compactMap( { $0.value })
                let sortedPosts = posts.sorted(by: { $0.timestamp > $1.timestamp })
                if reset {
                    self.posts = sortedPosts
                } else {
                    self.posts.append(contentsOf: sortedPosts)
                }
                completion()
                } catch let error {
                print("There was an error decoding from data: \(error.localizedDescription)")
                completion()
                return
            }
        }
        dataTask.resume()
    }
    
    func addNewPostWith(username: String, text: String, completion: @escaping (() -> Void)) {
        let post = Post(username: username, text: text)
        
        var postData: Data
        
        do {
            let jsonEncoder = JSONEncoder()
            postData = try jsonEncoder.encode(post)
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
            completion()
            return
        }
        let postEndpoint = PostController.baseURL.appendingPathExtension("json")
        var urlRequest = URLRequest(url: postEndpoint)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = postData
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print("Error with URL Session: \(error.localizedDescription)")
                completion()
                return
            }
            
            guard let data = data, let _ = String(data: data, encoding: .utf8) else {
                print("Data is nil")
                completion()
                return
            }
            
            self.fetchPosts {
                completion()
            }
        }
        dataTask.resume()
    }
}
