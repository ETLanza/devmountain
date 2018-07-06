//: Playground - noun: a place where people can play

import UIKit

class Car {
    
    var make: String
    var model: String
    var year: Int
    var vin: String
    
    init(make: String, model: String, year: Int, vin: String){
        self.make = make
        self.model = model
        self.year = year
        self.vin = vin
    }
}

let focus = Car(make: "Ford", model: "Focus", year: 2010, vin: "12KL90")
let rav4 = Car(make: "Toyota", model: "Rav4", year: 2015, vin: "KF83JN")
let f150 = Car(make: "Ford", model: "F150", year: 2018, vin: "BD8N22")
