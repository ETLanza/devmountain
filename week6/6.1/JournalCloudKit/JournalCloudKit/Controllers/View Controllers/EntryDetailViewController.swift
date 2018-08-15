//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by Eric Lanza on 8/6/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry? {
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty,
            let bodyText = bodyTextView.text, !bodyText.isEmpty else { return }
        EntryController.shared.addEntryWith(title: title, bodyText: bodyText) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.bodyText
        self.title = "Edit Entry"
    }
}
