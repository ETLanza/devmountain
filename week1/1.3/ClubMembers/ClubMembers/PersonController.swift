//
//  PersonController.swift
//  ClubMembers
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class PersonController {
    
    init() {
        persons = [Person(firstName: "James", lastName: "Pacheco", age: 26),
                   Person(firstName: "Andrea", lastName: "Mower", age: 24),
                   Person(firstName: "Rebecca", lastName: "Mordo", age: 30)]
    }
    
    func createPersonWith(firstName: String, lastName: String, age: Int) -> Person {
        let person = Person(firstName: firstName, lastName: lastName, age: age)
        persons.append(person)
        return person
    }
    
    // No delete or update property
    
    var persons: [Person]
}
