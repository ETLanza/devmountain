//
//  Grocery+Convenience.swift
//  ShoppingList
//
//  Created by Eric Lanza on 7/13/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

extension Grocery {
    convenience init(name: String, isInCart: Bool = false, category: String = "Grocery", context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.name = name
        self.isInCart = isInCart
        self.category = category
    }
}
