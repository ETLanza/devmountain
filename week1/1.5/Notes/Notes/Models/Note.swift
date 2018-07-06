//
//  Note.swift
//  Notes
//
//  Created by Eric Lanza on 7/6/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class Note: Equatable, Codable {
   
    //MARK: - Properties
    var bodyText: String
    init(bodyText: String) {
        self.bodyText = bodyText
    }
    
    //MARK: - Codable Method
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.bodyText == rhs.bodyText
    }
}
