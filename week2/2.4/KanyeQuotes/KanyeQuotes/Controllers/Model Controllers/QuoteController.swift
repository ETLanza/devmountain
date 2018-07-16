//
//  QuoteController.swift
//  KanyeQuotes
//
//  Created by Eric Lanza on 7/12/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

class QuoteController {
    
    //MARK: - Shared Instances
    static let shared = QuoteController()
    
    init(){
        do { try fetchedRequestController.performFetch()
        } catch {
            print("There was an error fetching results: \(error.localizedDescription)")
        }
    }
    
    //MARK: - FetchedRequestController
    let fetchedRequestController: NSFetchedResultsController<Quote> = {
        let fetchRequest: NSFetchRequest<Quote> = Quote.fetchRequest()
        let isKanyeSort = NSSortDescriptor(key: "isKanye", ascending: false)
        fetchRequest.sortDescriptors = [isKanyeSort]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: "isKanye", cacheName: nil)
    }()
    
    //MARK: - CRUD Functions
    func createQuoteWith(text: String) {
        let _ = Quote(text: text)
        saveToPersistentStore()
    }
    
    func toggleIsKanyeFor(quote: Quote) {
        quote.isKanye = !quote.isKanye
        saveToPersistentStore()
    }
    
    func delete(quote: Quote) {
        quote.managedObjectContext?.delete(quote)
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
