//
//  Person+Convenience.swift
//  PairProgramming
//
//  Created by Eric Lanza on 8/17/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

extension Person {
    convenience init(name: String,
                     context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        
        self.init(context: context)
        self.name = name
    }
}
