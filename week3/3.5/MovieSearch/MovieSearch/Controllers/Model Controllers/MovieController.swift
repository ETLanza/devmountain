//
//  MovieController.swift
//  MovieSearch
//
//  Created by Eric Lanza on 7/20/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class MovieController {
    
    //MARK: - Shared Instance
    static let shared = MovieController()
    
    //MARK: - Properties
    var movies: [Movie] = []
    
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    static let imageBaseURl = URL(string: "http://image.tmdb.org/t/p/w500")
    static let apiKey = "6f4d981b8c65512f465ce5bc85513205"
    
    //MARK: - GET Request for list of movies from API
    static func searchForMovieBy(searchTerm: String, completion: @escaping ((Bool) -> Void)) {
        guard let url = baseURL else { completion(false); return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let apiQueryItem = URLQueryItem(name: "api_key", value: apiKey)
        let searchTermQueryItem = URLQueryItem(name: "query", value: searchTerm)
        components?.queryItems = [apiQueryItem, searchTermQueryItem]
        guard let requestURL = components?.url else {completion(false); return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error retreiving data from URL: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let data = data else { completion(false); return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let topLevelDictionary = try jsonDecoder.decode(TopLevelJson.self, from: data)
                let movieItems = topLevelDictionary.results
                MovieController.shared.movies = movieItems
                completion(true)
            } catch let error {
                print("Error decoding from JSON: \(error.localizedDescription)")
                completion(false)
                return
            }
        }
        dataTask.resume()
    }
    
    //MARK: - GET Request for image of movie
    static func getPosterImageFor(movie: Movie, completion: @escaping ((UIImage?) -> Void)) {
        guard var url = imageBaseURl else { completion(nil); return }
        
        url.appendPathComponent(movie.imageAsString)
        print(url.absoluteString)

        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error getting Image from URL: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil); return }
            
            let image = UIImage(data: data)
            completion(image)
        }
        dataTask.resume()
    }
}
