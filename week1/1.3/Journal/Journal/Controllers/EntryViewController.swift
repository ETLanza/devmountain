//
//  EntryViewController.swift
//  Journal
//
//  Created by Eric Lanza on 7/5/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate{
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    //MARK: - IBActions

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        bodyTextView.text = ""
        titleTextField.text = ""
    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let titleText = titleTextField.text, titleText != "", let bodyText = bodyTextView.text, bodyText != "" else { return }
        if let entry = self.entry {
            EntryController.update(entry: entry, withNewTitle: titleText, andNewText: bodyText)
        } else {
            print("got to here")
            guard let journal = self.journal else { return }
            JournalController.addEntry(Entry.init(title: titleText, bodyText: bodyText), to: journal)
            JournalController.saveToPersistentStore()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    //MARK: Properties
    
    var entry: Entry?
//    var journal: Journal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        self.titleTextField.delegate = self
    }
    
    //MARK: - Text Field Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    //MARK: - Update Views
    
    func updateView() {
        if let entry = self.entry {
            bodyTextView.text = entry.bodyText
            titleTextField.text = entry.title
        }
    }
    
    
    
    
}
