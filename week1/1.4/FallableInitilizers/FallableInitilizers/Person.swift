//
//  Person.swift
//  FallableInitilizers
//
//  Created by Eric Lanza on 7/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class Person {
    
    var name: String
    var age: Int
    var favoriteMovie: String
    
    init?(_ dictionary: [String:Any]) {
        guard let name = dictionary["nameKey"] as? String,
            let age = dictionary["ageKey"] as? Int,
            let favoriteMovie = dictionary["favMovieKey"] as? String else { return nil}
        
        self.name = name
        self.age = age
        self.favoriteMovie = favoriteMovie
    }
}

let workingDictionar: [String: Any] =  ["nameKey" : "Derek", "ageKey": 28, "favMovieKey" : "Zoolander"]
let brokenDictionary: [String: Any] = ["nameKey" : "Steve", "ageKey": 2]
