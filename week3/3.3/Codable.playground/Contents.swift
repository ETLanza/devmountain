//: Codable

import UIKit

class Person: Codable {
    
    var name: String
    var age: Int
    var hasLice: Bool
    var timeSinceBirth: Double
    var siblingNames: [String]
}

let testDictionary: [String: Any] = ["name":"Derek","age":28,"hasLice":false,"timeSinceBirth":28.2345,"siblingNames":["Eve","Harmon","Gerald","Marty"]]

let jsonString = """

{

"name": "Derek",

"age": 28,

"hasLice": false,

"timeSinceBirth": 28.2345,

"siblingNames": ["Eve","Harmon","Gerald","Marty"]

}

"""

let data = jsonString.data(using: .utf8, allowLossyConversion: false)!

var derek: Person?

do {
    let jsonDecoder = JSONDecoder()
    let person = try jsonDecoder.decode(Person.self, from: data)
    derek = person
    person.name
    person.age
    person.hasLice
    person.siblingNames
} catch {
    print("Failed to deserialize JSON: \(error.localizedDescription)")
}

derek?.name
derek?.age
derek?.siblingNames
derek?.hasLice
