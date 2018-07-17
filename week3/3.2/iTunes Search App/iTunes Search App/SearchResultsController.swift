//
//  SearchResultsController.swift
//  iTunes Search App
//
//  Created by Eric Lanza on 7/16/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class SearchResultsController {
    
    static func serchResultsForSearhTerm(searchTerm: String, completion: @escaping (_ results: [SearchResult]?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)"
        guard let url = URL(string: urlString) else { return }
        
        fetchJSONAtURL(url: url) { (json) in
            guard let j = json, let allResults = j["results"] as? [[String: AnyObject]] else { return }
            let searchResults = allResults.compactMap({ return SearchResult(json: $0) })
            completion(searchResults)
        }
    }
    
//    static func albumCoverDownload(url: URL) -> URL {
//        let downloadTask = URLSession.shared.downloadTask(with: url) { (urlComp, _, error) in
//            if let error = error {
//                print("Error downloading album cover: \(error.localizedDescription)")
//            }
//            guard let urlComp = urlComp else { return }
//            do {
//                if let json = try JSONSerialization.json
//            }
//        }
//        downloadTask.resume()
//    }
    
    
    static func fetchJSONAtURL(url: URL, completion: @escaping (_ json: [String : AnyObject]?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print("Error downloading data: \(e.localizedDescription)")
                completion(nil)
                return
            } else if let d = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: d, options: []) as? [String: AnyObject ] {
                        completion(json)
                    }
                } catch let jsonError {
                    print("There was an error decoing JSON: \(jsonError.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
