/*:

## Control Flow

Write a function that prints the numbers from 1 to 100. But for multiples of three print “Dev” instead of the number and for the multiples of five print “Mountain”. For numbers which are multiples of both three and five print “DevMountain”.
*/
func devMountain() {
    for i in 1...100 {
        let devMountainTuple = (i % 3, i % 5)
        switch devMountainTuple {
        case (0, 0):
            print("DevMountain")
        case (0, _):
            print("Dev")
        case (_, 0):
            print("Mountain")
        case (_, _):
            print(i)
        }
    }
}
//: Demo the use of your function here. Go to View -> Debug Area -> Show Debug Area to see the logged results.
devMountain()

//: [Previous](@previous)
//: [Next](@next)
