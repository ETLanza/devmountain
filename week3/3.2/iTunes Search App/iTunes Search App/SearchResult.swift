//
//  SearchResult.swift
//  iTunes Search App
//
//  Created by Eric Lanza on 7/16/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class SearchResult {
    var artistName: String = ""
    var trackName: String = ""
    var itemDescription = ""
    var trackPrice = 0.0
    
    init?(json: [String:Any]) {
        guard let artistName = json["artistName"] as? String,
            let trackName = json["trackName"] as? String else { return }
        
        let itemDescription = json["description"]
        let price = json ["trackPrice"]
        self.artistName = artistName
        self.trackName = trackName
        
        if let trackP = price as? Double {
            self.trackPrice = trackP
        }
        
        if let d = itemDescription as? String {
            self.itemDescription = d
        }
    }
}
