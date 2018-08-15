//: Playground - noun: a place where people can play

import UIKit

func gameOfThrees(startNumber: Int) -> [Int: Int] {
    var dictInst = [Int: Int]()
    var number = startNumber
    
    while number > 0 {
        if number % 3 == 0 {
            number = number / 3
            dictInst[number] = 0
        }
        if number % 3 == 1 {
            dictInst[number] = -1
            number -= 1
        }
        if number % 3 == 2 {
            dictInst[number] = 1
            number += 1
        }
    }
    
    return dictInst
}

gameOfThrees(startNumber: 100)


func gameOfRecursion(startNumber: Int, startArray: [Int]) -> [Int] {
    var number = startNumber
    var array = startArray
    
    if number == 1 {
        return array
    }
    switch number % 3 {
    case 0:
        number = number / 3
        array.append(number)
        return gameOfRecursion(startNumber: number, startArray: array)
    case 1:
        array.append(number)
        number -= 1
        return gameOfRecursion(startNumber: number, startArray: array)
    case 2:
        array.append(number)
        number += 1
        return gameOfRecursion(startNumber: number, startArray: array)
    default:
        print("hi")
    }
    return array
}


gameOfRecursion(startNumber: 100, startArray: [])
