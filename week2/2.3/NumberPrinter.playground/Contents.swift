import UIKit

var stringZero: String = ""
var stringOne: String = ""
var stringTwo: String = ""
var stringThree: String = ""
var stringFour: String = ""

let zero = ["00000",
            "0   0",
            "0   0",
            "0   0",
            "00000"]

let one = [" 11  ",
           "1 1  ",
           "  1  ",
           "  1  ",
           "11111"]

let two = [" 222 ",
           "2   2",
           "   2 ",
           " 2   ",
           "22222"]

let three = ["33333",
             "    3",
             "33333",
             "    3",
             "33333"]

let four = ["4   4",
            "4   4",
            "44444",
            "    4",
            "    4"]

let five = ["55555",
            "5    ",
            "55555",
            "    5",
            "55555"]

let six = [" 666 ",
           "6    ",
           "66666",
           "6   6",
           "66666"]

let seven = ["77777",
             "   7 ",
             "  7  ",
             " 7   ",
             "7    "]

let eight = ["88888",
             "8   8",
             "88888",
             "8   8",
             "88888"]

let nine = ["99999",
            "9   9",
            "99999",
            "   9 ",
            "  9  "]


func numberToBreakDown(_ number:Int) -> [Int] {
    return String(number).compactMap { Int(String($0))}
}

func printArrayOnOneLine(_ array: [Int]) {
    var arrayOfArrays: [[String]] = []
    stringZero = ""
    stringOne = ""
    stringTwo = ""
    stringThree = ""
    stringFour = ""
    for i in array {
        var x = [String]()
        switch i {
        case 0: x = zero
        case 1: x = one
        case 2: x = two
        case 3: x = three
        case 4: x = four
        case 5: x = five
        case 6: x = six
        case 7: x = seven
        case 8: x = eight
        case 9: x = nine
        default: break
        }
        arrayOfArrays.append(x)
    }
    for y in (0...arrayOfArrays.count - 1) {
        stringZero.append(arrayOfArrays[y][0])
        stringOne.append(arrayOfArrays[y][1])
        stringTwo.append(arrayOfArrays[y][2])
        stringThree.append(arrayOfArrays[y][3])
        stringFour.append(arrayOfArrays[y][4])
        stringZero += " "
        stringOne += " "
        stringTwo += " "
        stringThree += " "
        stringFour += " "
    }

    print(stringZero)
    print(stringOne)
    print(stringTwo)
    print(stringThree)
    print(stringFour)

}

printArrayOnOneLine(numberToBreakDown(1234567890))
printArrayOnOneLine([1,5,7,3,7,4,8,3,8,9,3,0,1,5])


func numberPrinter(number: Int) -> [String]{
    switch number {
        case 0: return zero
        case 1: return one
        case 2: return two
        case 3: return three
        case 4: return four
        case 5: return five
        case 6: return six
        case 7: return seven
        case 8: return eight
        case 9: return nine
        default: return []
        }
}
        
        
func compactMap(number:Int) -> [Int] {
    return String(number).compactMap { Int(String($0))}
}

func numberPrinterOnArray(_ array: [Int]) {
    for i in array {
        let x = numberPrinter(number: i)
        print("\(x[0])")
        print("\(x[1])")
        print("\(x[2])")
        print("\(x[3])")
        print("\(x[4])")
        print("")
    }
    
}
print("")

let array = compactMap(number: 1234567890123456789)
numberPrinterOnArray(array)
