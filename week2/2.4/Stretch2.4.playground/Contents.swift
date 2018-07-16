//: Playground - noun: a place where people can play

import UIKit

let array = [26, 20, 30, 40, 39, 60, 52, 80, 90, 99]

func lowHighPrinter(for array: [Int]) {
    var defaultIndex = 0
    var x: Int? = nil
    for i in array {
        var printStatement: String = ""
        printStatement += (i > 50 ? "high" : "low")
        printStatement += (i % 13 == 0 ? ", didn't learn this one in school" : ", this is easy")
        let index = x ?? defaultIndex
        printStatement += i == array[index] ? ", getting bigger" : (i > array[index] ? ", getting bigger" : ", it's stopped growing")
        print(printStatement)
        defaultIndex += 1
        x = defaultIndex - 1
    }
}


lowHighPrinter(for: array)

func simplify(array: [Int]) -> [Int] {
    var sortedArray = array.sorted()
    let maxIndex = sortedArray.count - 1
    var y = 1
    var x = 0
    var burnerArray: [Int] = []
    print(sortedArray)
    for i in sortedArray {
        (y > maxIndex) ? (x = maxIndex) : (x = y)
        i != sortedArray[x] ? burnerArray.append(i) : sortedArray.append(x)
            y += 1
    }
    return burnerArray}

var smallArray = [0, 9, 8, 3, 3, 3, 5, 9, 5, 0]
let newArray = simplify(array: smallArray)
print(newArray)
