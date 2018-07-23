//
//  Character.swift
//  StarWars
//
//  Created by Eric Lanza on 7/19/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

struct TopLevelJSON: Codable {
    let individuals: [StarWarsCharacter]
}

struct StarWarsCharacter: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let birthdate: String
    let profilePicture: String?
    let forceSensitive: Bool
    let affiliation: String
    
}

extension StarWarsCharacter {
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let birthdate = dictionary["birthdate"] as? String,
            let profilePicture = dictionary["profilePicture"] as? String?,
            let forceSensitive = dictionary["forceSensitive"] as? Bool,
            let affiliation =  dictionary["affiliation"] as? String
            else { return nil }
        self.id = id
        self.firstName = firstName
        self .lastName = lastName
        self.birthdate = birthdate
        self.profilePicture = profilePicture
        self.forceSensitive = forceSensitive
        self.affiliation = affiliation
    }
}

