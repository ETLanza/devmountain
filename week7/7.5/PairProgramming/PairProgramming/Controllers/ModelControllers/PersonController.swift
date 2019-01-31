//
//  PersonController.swift
//  PairProgramming
//
//  Created by Eric Lanza on 8/17/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    //MARK: - Shared Instance
    static let shared = PersonController()
    
    //MARK: - Init
    init() {
        do {
           try fetchedResultsController.performFetch()
        } catch {
            print("Error performing person fetch: \(error.localizedDescription)")
        }
    }
    
    //MARK: - FetchedResultsController
    let fetchedResultsController: NSFetchedResultsController<Person> = {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [nameSort]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    //MARK: - CRUD Functions
    func createPersonWith(name: String) {
        let _ = Person(name: name)
        CoreDataManager.saveToPersistentStore()
    }
    
    func delete(person: Person) {
        CoreDataManager.delete(object: person)
    }
}
