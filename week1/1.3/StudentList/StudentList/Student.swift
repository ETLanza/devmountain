//
//  Student.swift
//  StudentList
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class Student {
    
    let firstName: String
    let lastName: String
    let age: Int
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age  
    }
}

extension Student {}

func ==(lhs: Student, rhs: Student) -> Bool {
    if lhs.firstName != rhs.firstName { return false }
    if lhs.lastName != rhs.lastName { return false }
    if lhs.age != rhs.age { return false }
    
    return true
}
