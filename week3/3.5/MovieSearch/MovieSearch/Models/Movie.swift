//
//  Movie.swift
//  MovieSearch
//
//  Created by Eric Lanza on 7/20/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

struct TopLevelJson: Decodable {
    let results: [Movie]
}

class Movie: Decodable {
    
    var title: String
    var rating: Double
    var summary: String
    var imageAsString: String
    var releaseDate: String
    var isFavorite: Bool = false
    
    init(title: String, rating: Double, summary: String, imageAsString: String, releaseDate: String) {
        self.title = title
        self.rating = rating
        self.summary = summary
        self.imageAsString = imageAsString
        self.releaseDate = releaseDate
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case rating = "vote_average"
        case summary = "overview"
        case imageAsString = "poster_path"
        case releaseDate = "release_date"
    }
}
