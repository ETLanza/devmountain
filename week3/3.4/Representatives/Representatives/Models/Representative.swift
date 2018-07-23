//
//  Representative.swift
//  Representatives
//
//  Created by Eric Lanza on 7/19/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

struct Representative: Codable {
    
    let name: String
    let party: String
    let state: String
    let district: String
    let phone: String
    let office: String
    let link: String
}
