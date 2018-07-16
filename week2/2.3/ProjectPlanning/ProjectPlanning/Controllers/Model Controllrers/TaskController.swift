//
//  TaskController.swift
//  ProjectPlanning
//
//  Created by Eric Lanza on 7/11/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    //MARK: - Shared Instance
    
    static let shared = TaskController()
    
    init(){
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error fetching results: \(error.localizedDescription)")
        }
    }
    
    let fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let isCompleteSort = NSSortDescriptor(key: "isComplete", ascending: true)
        let dueSort = NSSortDescriptor(key: "due", ascending: true)
        fetchRequest.sortDescriptors = [isCompleteSort, dueSort]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
    }()
    
    //MARK: - CRUD Functions
    func add(taskWithName name: String, notes: String?, due: Date?) {
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        task.managedObjectContext?.delete(task)
        saveToPersistentStore()
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
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
