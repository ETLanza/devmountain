//
//  ClubMembers.swift
//  ClubMembers
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class ClubMembers {
    
    init() {
        clubMembers = [Person(firstName: "James", lastName: "Pacheco", age: 26),
                       Person(firstName: "Andrea", lastName: "Mower", age: 24),
                       Person(firstName: "Rebecca", lastName: "Mordo", age: 30)]
    }
    
    // CRUD
    
    func addClubMember(_ clubMember: Person) {
        clubMembers.append(clubMember)
    }
    
    func deleteClubMember(_ person: Person) {
        if let index = clubMembers.index(where: {$0 == person }) {
            self.clubMembers.remove(at: index)
        }
    }
    
    var clubMembers = [Person]()

}
