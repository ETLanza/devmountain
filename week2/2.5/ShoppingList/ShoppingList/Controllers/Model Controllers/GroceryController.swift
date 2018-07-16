//
//  GroceryController.swift
//  ShoppingList
//
//  Created by Eric Lanza on 7/13/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

class GroceryController {
    
    //MARK: - Shared Instance
    static let shared = GroceryController()
    
    //MARK: - Init
    init() {
        do {
            try fetchedRequestController.performFetch()
        } catch {
            print("There was an error performing fetch: \(error.localizedDescription)")
        }
    }
    
    //MARK: - FetchedRequestController
    let fetchedRequestController: NSFetchedResultsController<Grocery> = {
        let fetchRequest: NSFetchRequest<Grocery> = Grocery.fetchRequest()
        let isInCartSort = NSSortDescriptor(key: "isInCart", ascending: true)
        let categorySort = NSSortDescriptor(key: "category", ascending: true)
        fetchRequest.sortDescriptors = [categorySort, isInCartSort]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: "category", cacheName: nil)
    }()
    
    //MARK: - CRUD Functions
    func createGroceryWith(name: String, category: String = "Grocery") {
        let _ = Grocery(name: name, category: category)
        saveToPersistentStore()
    }
    
    func delete(grocery: Grocery) {
        CoreDataStack.managedObjectContext.delete(grocery)
        saveToPersistentStore()
    }
    
    func toggleIsInCartFor(grocery: Grocery) {
        grocery.isInCart = !grocery.isInCart
        saveToPersistentStore()
    }
    
    //MARK: - Persistence
    private func saveToPersistentStore() {
        do {
            try CoreDataStack.managedObjectContext.save()
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
}
