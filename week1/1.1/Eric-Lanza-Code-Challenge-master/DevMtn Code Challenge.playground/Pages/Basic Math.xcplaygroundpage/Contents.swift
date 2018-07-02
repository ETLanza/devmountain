/*:
## Basic Math

Demonstrate basic knowledge of functions that take parameters and return results by implementing some basic math functions.
*/
//: Write a function that returns the sum of two numbers
func sumOf(_ x: Int, and y: Int) -> Int{
    return x + y
}

//: Write a function that returns the product of two numbers
func productOf(_ x: Int, and y: Int) -> Int {
    return x * y
}

//: Write a function that returns the average (mean) of an array of numbers
func averageOf(_ numbers: [Int]) -> Int {
    var sum = 0
    for i in numbers {
        sum += i
    }
    return sum / numbers.count
}

//: Demo the use of your functions here:
sumOf(10, and: 5)
productOf(10, and: 5)
averageOf([9, 8, 7, 6, 5])


//: [Previous](@previous)
//: [Next](@next)
