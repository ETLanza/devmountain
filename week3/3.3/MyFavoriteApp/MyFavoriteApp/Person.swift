//
//  Person.swift
//  MyFavoriteApp
//
//  Created by Eric Lanza on 7/17/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

struct Person: Codable {
    let name: String
    let favoriteApp: String
}

extension Person {
    init?(dict: [String: Any]) {
        guard let name = dict["name"] as? String,
            let favoriteApp = dict["favoriteApp"] as? String else {
            return nil
        }
        self.name = name
        self.favoriteApp = favoriteApp
    }
    
    var asJSONDictonary: [String:Any] {
        return ["name" : self.name, "favoriteApp" : self.favoriteApp]
    }
    
    var asData: Data? {
        return try? JSONSerialization.data(withJSONObject: asJSONDictonary, options: .prettyPrinted)
    }
}
