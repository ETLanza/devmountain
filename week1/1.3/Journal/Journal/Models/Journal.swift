//
//  Journal.swift
//  Journal
//
//  Created by Eric Lanza on 7/5/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class Journal: Equatable, Codable {
    
    var title: String
    var entries = [Entry]()
    
    init(title: String) {
        self.title = title
    }
    
    static func ==(lhs: Journal, rhs: Journal) -> Bool {
        return (lhs.title == rhs.title && lhs.entries == rhs.entries)
    }
    
    
}
