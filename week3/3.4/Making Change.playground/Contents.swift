//: Playground - noun: a place where people can play

import UIKit

func makeChangeFrom(cost: Double, paid: Double) -> String {
    
    var money = (paid - cost) * 100
    var remainingMoney = Int(money)
    var dollar: Int {
        var moneyToDivide = remainingMoney
        moneyToDivide /= 100
        remainingMoney -= (moneyToDivide * 100)
        return moneyToDivide
    }
    
    var quarter: Int {
        var moneyToDivide = remainingMoney
        moneyToDivide /= 25
        remainingMoney -= (moneyToDivide * 25)
        return moneyToDivide
    }
    var dime: Int {
        var moneyToDivide = remainingMoney
        moneyToDivide /= 10
        remainingMoney -= (moneyToDivide * 10)
        return moneyToDivide
    }
    var nickle: Int {
        var moneyToDivide = remainingMoney
        moneyToDivide /= 5
        remainingMoney -= (moneyToDivide * 5)
        return moneyToDivide
    }
    var penny: Int {
        var moneyToDivide = remainingMoney
        moneyToDivide /= 1
        remainingMoney -= (moneyToDivide * 1)
        return moneyToDivide
    }
    
    return "Your change is \(dollar) dollars, \(quarter) quarters, \(dime) dimes, \(nickle) nickles, and \(penny) pennies"

}

print(makeChangeFrom(cost: 3.06, paid: 5.00))

let array = [1,2,3,4,5,6,7,8]


