//: Playground - noun: a place where people can play

import UIKit

func longestWord(from string: String) -> String {
    
    var characterSet = CharacterSet()
    characterSet.formUnion(.whitespaces)
    characterSet.formUnion(.punctuationCharacters)
    characterSet.remove(charactersIn: "")
    
    let newArray = string.components(separatedBy: characterSet)
    
//    let array = string.split(separator: " ")
    
    let word = newArray.reduce("") { (longest, nextWord) -> String in
        if longest.count < nextWord.count {
            return String(nextWord)
        } else {
            return longest
        }
    }

    return word
}


longestWord(from: "how now brown cow!!!!!!!")



