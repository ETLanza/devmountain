//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Eric Lanza on 7/5/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entry: Entry!
    
    override func viewDidLoad() {
        if let entry = self.entry {
            entryTitleTextField.text = entry.title
            bodyTextField.text = entry.bodyText
        }
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    
    // MARK: IBActions
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let title = entryTitleTextField.text, title != "",
            let bodyText = bodyTextField.text, bodyText != ""
            else { return }
        if let entry = self.entry {
            EntryController.shared.updateEntry(entry, withNewTitle: title, andNewBody: bodyText)
        } else {
            EntryController.shared.addEntryWith(title: title, bodyText: bodyText)
        }
        let _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        entryTitleTextField.text = ""
        bodyTextField.text = ""
    }
}

