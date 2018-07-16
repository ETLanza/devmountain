//
//  ViewController.swift
//  CoreDataChallenge
//
//  Created by Eric Lanza on 7/10/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var personNameTextField: UITextField!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = personNameTextField.text else { return }
        _ = Person(name: name)
        saveToPersistentStore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var person: [Person] {
            let request: NSFetchRequest<Person> = Person.fetchRequest()
            do {
                return try CoreDataStack.context.fetch(request)
            } catch let error {
                print("Error fetching person: \(error)")
                return []
            }
        }
 
        personNameTextField.text = person.first?.name
    }
    
    private func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
    
}


