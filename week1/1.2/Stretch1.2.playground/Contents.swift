//: Playground - noun: a place where people can play

import UIKit

func numbersDivisibleBy(x: Int, betweenZeroAnd y: Int) {
    for number in 0...y {
        if number % x == 0 {
            print(number)
        }
    }
}

func printPrimeNumberBetweenZero(and y: Int){
    var counter = 0
    for x in 0...y {
        if x <= 1 {
        } else if x <= 3 {
            print(x)
        } else {
            for z in 2..<x {
                if x % z == 0 {
                    counter += 1
                    if counter > 0 {
                        break
                    }
                }
            }
        }
        if counter >= 1 {
            counter = 0
        } else if x > 3{
            print(x)
        }
    }
}




func cleanerPrimeNumberBetweenZero(and y: Int){
    for x in 0...y {
        switch x {
        case 0, 1: break
        case 2, 3: print(x)
        default:  if checkIfPrime(x) == true { print(x) }
        }
    }
}

func checkIfPrime(_ x: Int) -> Bool {
    for z in 2..<x {
        let k = ""
        if x % z == 0 {
            return false
        }
    }
    return true
}

//numbersDivisibleBy(x: 7, betweenZeroAnd: 100)
printPrimeNumberBetweenZero(and: 100)
//cleanerPrimeNumberBetweenZero(and: 100)


