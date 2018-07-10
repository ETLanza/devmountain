//: Playground - noun: a place where people can play

import UIKit


let date = NSDateComponents()
let calendar = Calendar.current
date.year = calendar.component(.year, from: Date())
let currentYear = date.year

print(date.year)

struct Person {
    let firstName: String
    let lastName: String
    var yearOfBirth: Int
    var age: Int {
         get {
            return currentYear - yearOfBirth
        } set {
            yearOfBirth = currentYear - newValue
        }
    }
}

var eric = Person(firstName: "Eric", lastName: "Lanza", yearOfBirth: 1991)
print(eric.age)
eric.age = 10
print(eric.yearOfBirth)
