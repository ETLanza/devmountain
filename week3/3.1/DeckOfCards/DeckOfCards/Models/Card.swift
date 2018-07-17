//
//  Card.swift
//  DeckOfCards
//
//  Created by Frank Martin Jr on 7/16/18.
//  Copyright © 2018 Frank Martin Jr. All rights reserved.
//

import Foundation

struct Deck: Codable {
    let cards: [Card]
}

struct Card: Codable {
    let image: String
    let value: String
    let suit: String
}
