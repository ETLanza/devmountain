//
//  CoreDataManager.swift
//  PairProgramming
//
//  Created by Eric Lanza on 8/17/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static func saveToPersistentStore() {
        do {
            try CoreDataStack.managedObjectContext.save()
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
    
    static func delete(object: NSManagedObject) {
        CoreDataStack.managedObjectContext.delete(object)
        saveToPersistentStore()
    }
}
