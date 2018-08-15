import UIKit

func gcd(x: Int, y: Int) -> Int {
    let result = x % y
    if result != 0 {
        return gcd(x: y, y: result)
    } else {
        return y
    }
}

gcd(x: 96, y: 64)
