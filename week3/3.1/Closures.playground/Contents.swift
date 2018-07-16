import UIKit

let array = [11,23,43,44,59,43,88,92,58,11,13,14,15]

let filterArray = array.filter { (int) -> Bool in
    return int % 3 == 0
}
print(filterArray)

let largestInt = array.reduce(0) { (result, int) -> Int in
    if int > result {
        return int
    } else {
        return result
    }
}

print(largestInt)

let stringArray = ["I", "Love", "Dev Mountain"]

let reducedString = stringArray.reduce("") { (result, string) -> String in
    return result + string + " "
}

print(reducedString)


let porridge = [["Mama": "too cold", "Papa": "too hot", "Baby": "just right"]]

let newArray = porridge.compactMap { array in
    return array
}
print(newArray)
