//: JSONDeserialization

import UIKit

class Person {
    
    var name: String = ""
    var age: Int = 0
    var hasLice: Bool = false
    var siblingNames: [String] = []
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let age = dictionary["age"] as? Int,
            let hasLice = dictionary["hasLice"] as? Bool,
            let siblingNames = dictionary["siblingNames"] as? [String] else { return }
        self.name = name
        self.age = age
        self.hasLice = hasLice
        self.siblingNames = siblingNames
    }
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

func jsonObject(data: Data) -> [String:Any]? {
    do {
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
            return json
        }
    } catch let error {
        print("fuck errors, \(error)")
    }
    return nil
}


let person = jsonObject(data: data)
person?["name"]
person?["age"]
person?["hasLice"]
person?["siblingNames"]
