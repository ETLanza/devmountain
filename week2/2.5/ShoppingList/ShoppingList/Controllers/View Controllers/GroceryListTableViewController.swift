//
//  GroceryListTableViewController.swift
//  ShoppingList
//
//  Created by Eric Lanza on 7/13/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit
import CoreData

class GroceryListTableViewController: UITableViewController {
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        GroceryController.shared.fetchedRequestController.delegate = self
    }
    
    //MARK: - IBActions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        displayAlert()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return GroceryController.shared.fetchedRequestController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return GroceryController.shared.fetchedRequestController.sections?[section].name ?? "Grocery"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroceryController.shared.fetchedRequestController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell() }
        
        let grocery = GroceryController.shared.fetchedRequestController.object(at: indexPath)
        cell.delegate = self
        cell.primaryLabel.text = grocery.name
        cell.updateButton(grocery.isInCart)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let grocery = GroceryController.shared.fetchedRequestController.object(at: indexPath)
            GroceryController.shared.delete(grocery: grocery)
        }
    }
}

//MARK: - ButtonTableViewCell Delegate Method
extension GroceryListTableViewController: ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else { return }
        let grocery = GroceryController.shared.fetchedRequestController.object(at: index)
        GroceryController.shared.toggleIsInCartFor(grocery: grocery)
        sender.update(withGrocery: grocery)
    }
}

//MARK: - FetchedResultsController Delegate Methods
extension GroceryListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .delete:
            tableView.deleteSections(indexSet, with: .automatic)
        case .insert:
            tableView.insertSections(indexSet, with: .automatic)
        default:
            return
        }
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

//MARK: - Alert Controller
extension GroceryListTableViewController {
    
    func displayAlert() {
        let alertController = UIAlertController(title: "Add Item", message: "Please add an item to your shopping list", preferredStyle: .alert)
        
        var nameTextField: UITextField?
        var categoryTextField: UITextField?
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter name of item..."
            nameTextField = textField
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter category of item..."
            categoryTextField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = nameTextField?.text, !name.isEmpty,
                let category = categoryTextField?.text else { return }
            if category.isEmpty {
                GroceryController.shared.createGroceryWith(name: name)
            } else {
                GroceryController.shared.createGroceryWith(name: name, category: category)
            }
        }
        alertController.addAction(addAction)
        
        present(alertController, animated: true)
    }
}
