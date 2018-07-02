class Person {
    let name: String
    var favoriteColor: String? = nil
    var favoriteMovie: String? = nil
    
    init(name: String) {
        self.name = name
    }
    
    func printDescription() {
        if let movie = myPerson.favoriteMovie, let color = myPerson.favoriteColor {
            print("\(name)'s favorite color is \(color) and favorite movie is \(movie).")
        } else if let movie = myPerson.favoriteMovie {
            print("\(name)'s favorite movie is \(movie).")
        } else if let color = myPerson.favoriteColor {
            print("\(name)'s favorite color is \(color)")
        } else {
            print("\(name) doesnt like anything.")
        }
    }
}

let myPerson = Person(name: "Eric")
myPerson.favoriteColor = "Red"
myPerson.favoriteMovie = "Star Wars"

if let movie = myPerson.favoriteMovie {
    print("\(myPerson.name)'s favorite movie is \(movie)")
}

if let color = myPerson.favoriteColor {
    print("\(myPerson.name)'s favorite color is \(color)")
}

myPerson.printDescription()
