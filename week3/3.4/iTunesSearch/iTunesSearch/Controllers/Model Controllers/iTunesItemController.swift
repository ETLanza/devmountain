//
//  iTunesItemController.swift
//  iTunesSearch
//
//  Created by Eric Lanza on 7/19/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class iTunesItemController {
    
    static let baseURL = URL(string: "https://itunes.apple.com")
    
    static func getItunesItems(for searchTerm: String, completion: @escaping (([iTunesItem]?) -> Void)) {
        
        guard var url = baseURL else { completion(nil); return }
        
        url.appendPathComponent("search")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let mediaQueryItem = URLQueryItem(name: "media", value: "music")
        components?.queryItems = [searchTermQueryItem, mediaQueryItem]
        guard let requestURL = components?.url else { completion(nil); return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error retrieving the iTunes items: \(error.localizedDescription)")
            }
            
            guard let data = data else { completion(nil); return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let topLevelDictionary = try jsonDecoder.decode(TopLevelDictionary.self, from: data)
                let iTunesItems = topLevelDictionary.results
                completion(iTunesItems)
            } catch {
                print(error)
                completion(nil)
                return
            }
        }.resume()
    }
    
    static func getImage(for iTunesItem: iTunesItem, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: iTunesItem.imageURLAsString) else { completion(nil); return }
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print("Error getting image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil); return }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
