//: Playground - noun: a place where people can play

import UIKit

class Person {
    
    var name: String
    var age: Int
    var favoriteMovie: String
    
    init(name: String, age: Int, favoriteMovie: String) {
        self.name = name
        self.age = age
        self.favoriteMovie = favoriteMovie
        
    }
    init?(_ dictionary: [String:Any]) {
        guard let name = dictionary["nameKey"] as? String,
            let age = dictionary["ageKey"] as? Int,
            let favoriteMovie = dictionary["favMovieKey"] as? String else { return nil }
        
        self.name = name
        self.age = age
        self.favoriteMovie = favoriteMovie
    }
}

let workingDictionary: [String: Any] =  ["nameKey" : "Derek", "ageKey": 28, "favMovieKey" : "Zoolander"]
let brokenDictionary: [String: Any] = ["nameKey" : "Steve", "ageKey": 2]

var newPerson = Person(workingDictionary)
var nilPerson = Person(brokenDictionary)


