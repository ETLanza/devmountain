//
//  RestaurantController.swift
//  RestaurantRater
//
//  Created by Eric Lanza on 7/14/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

class RestaurantController {
    
    //MARK: - Shared Instance
    static let shared = RestaurantController()
    
    //MARK: - Init
    init() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error performing fetch \(error.localizedDescription)")
        }
    }
    
    //MARK: - FetchedResultsController
    let fetchedResultsController: NSFetchedResultsController<Restaurant> = {
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    //MARK: - CRUD Functions
    func createRestaurantWith(name: String) {
        let _ = Restaurant(name: name)
        saveToPersistentStore()
    }
    
    func delete(restaurant: Restaurant) {
        CoreDataStack.managedObjectContext.delete(restaurant)
        saveToPersistentStore()
    }
    
    //MARK: - Helper Methods
    func toggleIsGoodFor(restaurant: Restaurant) {
        restaurant.isGood = !restaurant.isGood
        saveToPersistentStore()
    }
    
    //MARK: - Persistence
    func saveToPersistentStore() {
        do {
            try CoreDataStack.managedObjectContext.save()
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
}
