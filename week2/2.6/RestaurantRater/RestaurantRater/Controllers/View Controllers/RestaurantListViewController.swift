//
//  RestaurantListViewController.swift
//  RestaurantRater
//
//  Created by Eric Lanza on 7/14/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit
import CoreData

class RestaurantListViewController: UIViewController{
    
    //MARK: - Properties
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        displayAlert()
    }
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        RestaurantController.shared.fetchedResultsController.delegate = self
    }
}

//MARK: - UITableViewDataSource Methods
extension RestaurantListViewController:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantController.shared.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as? RestaurantTableViewCell else { return UITableViewCell() }
       let restaurant = RestaurantController.shared.fetchedResultsController.object(at: indexPath)
        
        cell.restaurant = restaurant
        cell.delegate = self
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let restaurant = RestaurantController.shared.fetchedResultsController.object(at: indexPath)
            RestaurantController.shared.delete(restaurant: restaurant)
        }
    }
}

extension RestaurantListViewController: RestaurantTableViewCellDelegate {
    func thumbsUpDownButtonTapped(_ sender: RestaurantTableViewCell) {
        guard let restaurant = sender.restaurant else { return }
        RestaurantController.shared.toggleIsGoodFor(restaurant: restaurant)
//        sender.buttonTapped(sender)
    }
}

//MARK: - Alert Controller
extension RestaurantListViewController {
    func displayAlert() {
        let alertController = UIAlertController(title: "Add a new restaurant", message: "Enter the restaurant name below.", preferredStyle: .alert)
        var nameTextField: UITextField?
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter restaurant's name..."
            nameTextField = textfield
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (add) in
            guard let name = nameTextField?.text else { return }
            RestaurantController.shared.createRestaurantWith(name: name)
        }
        alertController.addAction(addAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension RestaurantListViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let newIndexPath = newIndexPath else { return }
            guard let indexPath = indexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

