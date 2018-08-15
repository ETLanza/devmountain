//
//  EntryDetailViewController.swift
//  CKUsers
//
//  Created by Eric Lanza on 8/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entry: Entry?
    {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty,
            let body = bodyTextView.text, !body.isEmpty else { return }
        
        if let entry = entry {
            EntryController.shared.modifyEntryInCloudKit(entry: entry, withTitle: title, body: body) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            EntryController.shared.createNewEntryWith(title: title, body: body) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let entry = entry else { return }
        self.title = "Edit Entry"
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
}
