//
//  Entry.swift
//  Journal
//
//  Created by Eric Lanza on 7/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class Entry: Equatable, Codable {
    
    var title: String
    var bodyText: String
    let timeStamp: Date
    
    init(title: String, bodyText: String) {
        self.title = title
        self.bodyText = bodyText
        self.timeStamp = Date()
    }

    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return (lhs.title == rhs.title && lhs.bodyText == rhs.bodyText && lhs.timeStamp == rhs.timeStamp)
    }
}
