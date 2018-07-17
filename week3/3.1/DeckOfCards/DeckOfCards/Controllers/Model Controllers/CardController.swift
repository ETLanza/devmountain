//
//  CardController.swift
//  DeckOfCards
//
//  Created by Frank Martin Jr on 7/16/18.
//  Copyright © 2018 Frank Martin Jr. All rights reserved.
//

import UIKit

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/")
    
    static func draw(numberOfCards: Int) -> Deck? {
        // Step 1 - Constructing our URL
        guard let url = baseURL else { return nil }
       
        // Step 2 - Construct components
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let countQueryItem = URLQueryItem(name: "count", value: "\(numberOfCards)")
        components?.queryItems = [countQueryItem]
        print(components?.url)
        
        // Step 3 - Request
        guard let requestURL = components?.url else { return nil }
        
        let data = try! Data(contentsOf: requestURL)
        
        let jsonDecoder = JSONDecoder()
        let deck = try! jsonDecoder.decode(Deck.self, from: data)
        
        return deck
        
    }
    
    static func getImage(urlAsString: String) -> UIImage? {
        
        guard let urlForImage = URL(string: urlAsString) else { return nil }
        print(urlForImage)
        
        let data = try! Data(contentsOf: urlForImage)
        let image = UIImage(data: data)
        
        return image
    }
}











