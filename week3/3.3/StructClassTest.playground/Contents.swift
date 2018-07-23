//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class PersonController {
    
    func changeNameOf(person: Person, name: String) {
        person.name = name
    }
}

let personController = PersonController()

let personController2 = PersonController()
