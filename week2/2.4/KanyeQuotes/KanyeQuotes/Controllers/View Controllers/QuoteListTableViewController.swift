//
//  QuoteListTableViewController.swift
//  KanyeQuotes
//
//  Created by Eric Lanza on 7/12/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class QuoteListTableViewController: UITableViewController {
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        QuoteController.shared.fetchedRequestController.delegate = self
    }
    
    //MARK: - IBActions
    @IBAction func newQuoteButtonPressed(_ sender: UIBarButtonItem) {
        displayAlert()
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return QuoteController.shared.fetchedRequestController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return QuoteController.shared.fetchedRequestController.sectionIndexTitles[section] == "1" ? "Kanye Quote" : "Not a Kanye Quote"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuoteController.shared.fetchedRequestController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell()}
        
        let quote = QuoteController.shared.fetchedRequestController.object(at: indexPath)
        cell.delegate = self
        cell.primaryLabel.text = quote.text
        cell.updateButton(quote.isKanye)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let quote = QuoteController.shared.fetchedRequestController.object(at: indexPath)
            QuoteController.shared.delete(quote: quote)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuoteDetailVC" {
            guard let index = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? QuoteDetailViewController else { return }
            let quote = QuoteController.shared.fetchedRequestController.object(at: index)
            destinationVC.quote = quote
        }
    }
}

//MARK: - ButtonTableViewCellDelegate Methods
extension QuoteListTableViewController: ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else { return }
        let quote = QuoteController.shared.fetchedRequestController.object(at: index)
        QuoteController.shared.toggleIsKanyeFor(quote: quote)
        sender.update(withQuote: quote)
    }
}

//MARK: - NSFetchedResultsControllerDelegate Methods
extension QuoteListTableViewController: NSFetchedResultsControllerDelegate {
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
            tableView.deleteSections(indexSet, with: .fade)
        case .insert:
            tableView.insertSections(indexSet, with: .fade)
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

//MARK: - Alert Controller Method
extension QuoteListTableViewController {
    func displayAlert() {
        let alertController = UIAlertController(title: "Yo", message: "Gimme a quote", preferredStyle: .alert)
        var quoteTextField: UITextField?
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Gimme a quote, yo!"
            quoteTextField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Add", style: .default) { (okAction) in
            guard let text = quoteTextField?.text, !text.isEmpty else { return }
            QuoteController.shared.createQuoteWith(text: text)
        }
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
