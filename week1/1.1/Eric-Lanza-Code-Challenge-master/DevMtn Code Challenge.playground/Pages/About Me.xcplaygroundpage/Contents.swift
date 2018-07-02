/*:
## About Me

Tell us a little bit about yourself using Swift variables. Start with your first name, your last name, your age, where you're from, and why you want to take the class.
*/
var firstName = "Eric"
var lastName = "Lanza"
var myAge = 27
var myHometown = "Boca Raton, Florida"
var myReason = "I want to take this class because I want further my professional self with a career I am fully interested in"
//: Create an array of Strings that holds a few of your hobbies.
var myHobbies: [String] = ["Frisbee", "Video games", "Sleeping"]
myHobbies[1]

/*: 
Programmatically combine the individual strings from your hobbies array into a single string with the hobbies separated by commas.

For example: "Programming, Teaching, Golf, and Basketball."
*/
let myHobbiesString = "\(myHobbies[0]), \(myHobbies[1]), and \(myHobbies[2])"

//: Using the variables you have created, write a programmatically generated sentence to introduce yourself. Use only one print() statement.
print("My name is \(firstName) \(lastName).  I am \(myAge) years old and am from \(myHometown). \(myReason). Some of my hobbies include \(myHobbiesString)")

//: [Previous](@previous)
//: [Next](@next)
