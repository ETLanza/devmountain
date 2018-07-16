//
//  Quote+Convenience.swift
//  KanyeQuotes
//
//  Created by Eric Lanza on 7/12/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

extension Quote {
    convenience init(text: String, isKanye: Bool = false, context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.text = text
        self.isKanye = isKanye
    }
}
