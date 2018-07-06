//
//  Note.swift
//  Notes
//
//  Created by Eric Lanza on 7/6/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class Note: Equatable, Codeable {
    
    var bodyText: String
    
    init(bodyText: String) {
        self.bodyText = bodyText
    }
    
    
    
    
}
