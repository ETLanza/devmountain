//
//  Post.swift
//  POST
//
//  Created by Eric Lanza on 7/16/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

struct Post: Codable {
    init(username: String, text: String, timestamp: TimeInterval = Date().timeIntervalSince1970) {
        self.username = username
        self.text = text
        self.timestamp = timestamp
    }
    let username: String
    let text: String
    let timestamp : TimeInterval
}


