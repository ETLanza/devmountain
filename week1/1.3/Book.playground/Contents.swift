//: Playground - noun: a place where people can play

import UIKit

class Book {
    
    var title: String
    var author: String
    var genre: String
    
    init(title: String, author: String, genre: String) {
        self.title = title
        self.author = author
        self.genre = genre
    }
}

extension Book {}

func ==(lhs: Book, rhs: Book) -> Bool {
    if lhs.title != rhs.title { return false }
    if lhs.author != rhs.author { return false }
    if lhs.genre != rhs.genre { return false }

    return true
}

class BookShelf {
    
    init() {
        self.books = [
            Book(title: "The Fellowship of the Ring", author: "J.R.R. Tolkien", genre: "Fantasy"),
            Book(title: "The Two Towers", author: "J.R.R. Tolkien", genre: "Fantasy"),
            Book(title: "The Return of The King", author: "J.R.R. Tolkien", genre: "Fantasy")
        ]
    }
    
    //CRUD
    
    func createBookWith(title: String, author: String, genre: String) -> Book {
        let book = Book(title: title, author: author, genre: genre)
        books.append(book)
        return book
    }
    
    func deleteBook(_ book: Book) {
        if let index = books.index(where: { $0 == book }) {
            books.remove(at: index)
        }
    }
    
    var books = [Book]()
}
