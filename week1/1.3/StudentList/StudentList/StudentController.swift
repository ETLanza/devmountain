//
//  StudentController.swift
//  StudentList
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class StudentController {
    
    static let shared = StudentController()
    
    init() {
        students = [
            Student(firstName: "Andrew", lastName: "Madsen", age: 32),
            Student(firstName: "Steve", lastName: "Jobs", age: 62),
            Student(firstName: "Johnny", lastName: "Appleseed", age: 200)
        ]
    }
    
    //CRUD
    
    func createStudentWith(firstName: String, lastName: String, age: Int) -> Student {
        let student = Student(firstName: firstName, lastName: lastName, age: age)
        
        students.append(student)
        
        return student
    }
    
    func deleteStudent(student: Student) {
        if let index = students.index(where: { $0 == student }) {
            self.students.remove(at: index)
        }
    }
    
    var students: [Student]
    
}
