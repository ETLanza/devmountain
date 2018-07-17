//
//  PostController.swift
//  POST
//
//  Created by Eric Lanza on 7/16/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class PostController {
    
    static var posts: [Post] = []
    
    static let baseURL = URL(string: "https://devmtn-posts.firebaseio.com/posts")!
    
    static let getterEndpoint = baseURL.appendingPathExtension("json")
    
    func fetchPost(completion: @escaping () -> ()){
        let request = URLRequest(url: PostController.getterEndpoint)
        let dataRequest = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("There was an error with the dataTask: \(error.localizedDescription)")
                completion()
                return
            }
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let postsDictionary = try decoder.decode([String:Post].self, from: data)
                var posts: [Post] = postsDictionary.compactMap({ $0.value })
                posts.sort(by: { (x, y) -> Bool in
                    return x.timestamp > y.timestamp
                })
                PostController.posts = posts
                completion()
            } catch let error {
                print("There was an error decoding from data: \(error.localizedDescription)")
                completion()
                return
            }
        }
        dataRequest.resume()
    }
}
