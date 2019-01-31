//
//  RepresentativeController.swift
//  Representatives
//
//  Created by Eric Lanza on 7/19/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class RepresentativeController {
    
    static let baseURL = URL(string: "http://whoismyrepresentative.com/getall_reps_bystate.php")
    
    static func searchRepresentatives(forState state: String, completion: @escaping (([Representative]) -> Void)) {
        guard let url = baseURL else { completion([]); return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let stateQuery = URLQueryItem(name: "state", value: state.lowercased())
        let jsonQuery = URLQueryItem(name: "output", value: "json")
        components?.queryItems = [stateQuery, jsonQuery]
        guard let requestURL = components?.url else { completion([]); return }
        print(requestURL.absoluteString)
        
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("Error getting representatives: \(error.localizedDescription)")
            }
            guard let data = data,
            let responseDataString = String(data: data, encoding: .ascii),
            let fixedData = responseDataString.data(using: .utf8)
            else { completion([]); return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let decodedData = try jsonDecoder.decode([String: [Representative]].self, from: fixedData)
                let repArray = decodedData["results"]
                completion(repArray ?? [])
            } catch {
                print("Error decoding json: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
