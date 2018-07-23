//: Playground - noun: a place where people can play

import UIKit


func convertToScientificNotation(_ number: Float) -> String {
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .scientific
    formatter.positiveFormat = "#.###E0"
    formatter.negativeFormat = "#.###E0"
    formatter.exponentSymbol = " * 10 ^ "
    guard let number = formatter.string(from: NSNumber(value: number)) else { return "Incorrect format" }
    return number
}

let float: Float = 105

convertToScientificNotation(float)


