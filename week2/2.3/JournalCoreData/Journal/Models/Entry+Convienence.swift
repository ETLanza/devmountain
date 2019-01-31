//
//  Entry+Convienence.swift
//  Journal
//
//  Created by Eric Lanza on 7/10/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    
    @discardableResult
    convenience init(title: String, bodyText: String, timeStamp: Date = Date(), context: NSManagedObjectContext = CoreDataStack.context) {
    
    self.init(context: context)
    
    self.title = title
    self.bodyText = bodyText
    self.timeStamp = timeStamp
    }
}
