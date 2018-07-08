//
//  Friend.swift
//  FriendRater
//
//  Created by Eric Lanza on 7/7/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

import Foundation

class Friend: Codable {
    
    //MARK: - Properties
    var name: String
    var rating: Int
    
    //MARK: - Life Cycle Methods
    init(name: String, rating: Int) {
        self.name = name
        self.rating = rating
    }
}

    //MARK: - Equatable Protocol
extension Friend: Equatable {
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.name == rhs.name && lhs.rating == rhs.rating
    }
}
