//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Eric Lanza on 7/5/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entry: Entry?
    
    override func viewDidLoad() {
        if let entry = self.entry {
            titleTextField.text = entry.title
            bodyTextField.text = entry.bodyText
        }
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    
    // MARK: IBActions
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, title != "",
            let bodyText = bodyTextField.text, bodyText != ""
            else { return }
        if let entry = self.entry {
            EntryController.shared.update(entry: entry, withNewTitle: title, andNewBody: bodyText)
        } else {
            EntryController.shared.createEntryWith(title: title, bodyText: bodyText)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        titleTextField.text = ""
        bodyTextField.text = ""
    }
}

