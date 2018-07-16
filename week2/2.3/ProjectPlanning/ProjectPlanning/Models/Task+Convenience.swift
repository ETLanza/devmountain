//
//  Task+Convenience.swift
//  ProjectPlanning
//
//  Created by Eric Lanza on 7/11/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    convenience init(name: String, notes: String?, due: Date? = nil, context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.due = due
        self.isComplete = false
    }
}
