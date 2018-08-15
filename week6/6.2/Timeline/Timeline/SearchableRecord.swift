//
//  SearchableRecord.swift
//  Timeline
//
//  Created by Eric Lanza on 8/7/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

protocol SearchableRecord {
    func matches(searchTerm: String) -> Bool
}
