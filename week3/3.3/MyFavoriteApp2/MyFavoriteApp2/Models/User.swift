//
//  User.swift
//  MyFavoriteApp2
//
//  Created by Eric Lanza on 7/18/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case favoriteApp = "favApp"
    }
    
    let name: String
    let favoriteApp: String
}
