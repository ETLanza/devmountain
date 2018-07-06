//: Playground - noun: a place where people can play

import UIKit

struct Movie: Codable {
    var name: String
    var sales: Int
    var rating: String
    var reviewscore: Double
    var actor: String
}

let deadpoolJson = """
{
    "name" : "Deadpool",
    "sales" : 363024000,
    "rating" : "R",
    "reviewscore" : 4.5,
    "actor" : "Ryan Reynolds"
}
"""

let jd = JSONDecoder()

if let deadpoolJsonData = deadpoolJson.data(using: .utf8) {
    do {
        let deadpool = try jd.decode(Movie.self, from: deadpoolJsonData)
        deadpool.name
        deadpool.sales
    } catch let e {
        print("Error decoding json \(e)")
    }
}

let spiderman = Movie(name: "Spiderman", sales: 319000000, rating: "PG-13", reviewscore: 4.5, actor: "Tom Holland")

let je = JSONEncoder()

do {
    let data = try je.encode(spiderman)
    let dataString = String(bytes: data, encoding: .utf8)
    print(dataString)

} catch let e {
    print("Error endoing object \(e)")
}
