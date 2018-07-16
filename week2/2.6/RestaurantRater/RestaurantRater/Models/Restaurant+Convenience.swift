//
//  Restaurant+Convenience.swift
//  RestaurantRater
//
//  Created by Eric Lanza on 7/14/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData
extension Restaurant {
    convenience init(name: String, isGood: Bool = true, context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.name = name
        self.isGood = isGood
    }
}
