import UIKit

func addIntsInString(str: String) -> Int {
    let testStr = str.lowercased()
    var returnInt = 0
    let removeCase = "abcdefghijklmnopqrstuvwxyz"
    var numberToAdd: String = ""
    
    for char in testStr {
        if !numberToAdd.isEmpty {
            if removeCase.contains(char) {
                returnInt += Int(numberToAdd)!
                numberToAdd = ""
                continue
            } else {
                numberToAdd.append(char)
                if char == testStr.last {
                    returnInt += Int(numberToAdd)!
                }
                continue
            }
        } else if removeCase.contains(char) {
            returnInt += Int(numberToAdd)!
            numberToAdd = ""
            continue
        } else {
            numberToAdd.append(char)
        }
    }
    
    return returnInt
}


addIntsInString(str: "41k2l3l41a")
