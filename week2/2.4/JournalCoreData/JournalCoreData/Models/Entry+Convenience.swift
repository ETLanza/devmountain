//
//  Entry+Convenience.swift
//  JournalCoreData
//
//  Created by Eric Lanza on 7/12/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    convenience init(title: String,
                     bodyText: String,
                     isGoodDay: Bool,
                     context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.title = title
        self.bodyText = bodyText
        self.isGoodDay = isGoodDay
        timeStamp = Date()
    }
}
