//: Playground - noun: a place where people can play

import UIKit

struct Restaurant {
    var name: String
    var streetAddress: String
    var city: String
    var state: String
    var reviews: [Review]
    
}

struct Review {
    var username: String
    var text: String
    private let hash = "#"
    var hashtags: String? {
        if text.contains(hash) {
            let hashStartIndex = text.index(of: "#")
            let hashEndIndex = text.index(text.index(of: " ")!, offsetBy: (hashStartIndex?.hashValue)!)
            var hashtag: String = ""
            for int in (hashStartIndex?.hashValue)! ... hashEndIndex.hashValue {
                let index = text.index(text.startIndex, offsetBy: int)
                hashtag.append(text[index])
            }
            return hashtag
        }
        return nil
    }
}

var jdawgs = Restaurant(name: "Jdawgs", streetAddress: "341 Main Street", city: "Salt Lake City", state: "Utah", reviews: [])

jdawgs.reviews.append(Review(username: "Connor", text: "I am obsessed with this place! #whatthehelldidijustwrite"))

jdawgs.reviews
