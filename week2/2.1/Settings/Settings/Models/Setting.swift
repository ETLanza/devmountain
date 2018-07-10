//
//  Setting.swift
//  Settings
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class Setting: Equatable {

    let name: String
    let image: UIImage?
    var isSet: Bool
    
    init(name: String, image: UIImage?) {
        self.name = name
        self.image = image
        self.isSet = false
    }
    
    static func == (lhs: Setting, rhs: Setting) -> Bool {
        return lhs.name == rhs.name && lhs.image == rhs.image && lhs.isSet == rhs.isSet
    }
}
