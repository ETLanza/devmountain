import UIKit

protocol Vehicle {
    var speed: Double { get set }
    var isMoving: Bool { get set }
    //    func startMoving()
    //    func stopMoving()
}

extension Vehicle {
    mutating func startMoving() {
        if !isMoving {
            isMoving = true
            print("Started moving")
        } else {
            print("Already moving")
        }
    }
    
    mutating func stopMoving() {
        if isMoving {
            isMoving = false
            print("Stopped moving")
        } else {
            print("Already stopped")
        }
    }
}

protocol Racer: Vehicle {
    func race() -> Double
}

extension Racer {
    func race() -> Double {
        return 1000.0 / speed
    }
}

class Truck: Vehicle {
    var speed: Double
    var isMoving: Bool
    
    func truckStartMoving() {
        speed = 90
    }
    
    init(speed: Double) {
        self.speed = speed
        isMoving = false
    }
}

class Lawnmower: Vehicle {
    var speed: Double
    
    var isMoving: Bool
    
    init(speed: Double) {
        self.speed = speed
        isMoving = false
    }
}

var truck = Truck(speed: 120)
truck.speed
truck.startMoving()
truck.speed
truck.startMoving()
truck.stopMoving()
truck.stopMoving()
var lawnmower = Lawnmower(speed: 10.0)
lawnmower.startMoving()
lawnmower.startMoving()
lawnmower.stopMoving()
lawnmower.stopMoving()

class Camaro: Racer {
    var speed: Double
    
    var isMoving: Bool
    
    init(speed: Double) {
        self.speed = speed
        isMoving = false
    }
}

class Challenger: Racer {
    var speed: Double
    
    var isMoving: Bool
    
    init(speed: Double) {
        self.speed = speed
        isMoving = false
    }
}

let camaro = Camaro(speed: 150)
let challenger = Challenger(speed: 200)

func race(car1: Racer, car2: Racer) -> String {
    if car1.race() < car2.race() {
        return "Car one is the winner"
    } else if car1.race() == car2.race() {
        return "Its a tie!"
    } else {
        return "Car two is the winner"
    }
}

let results = race(car1: camaro, car2: challenger)
let results2 = race(car1: challenger, car2: camaro)
print(results)
print(results2)



