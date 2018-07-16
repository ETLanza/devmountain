//
//  DetailViewController.swift
//  JournalCoreData
//
//  Created by Eric Lanza on 7/12/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    //MARK: - Properties
    var entry: Entry? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var dayTypeSC: UISegmentedControl!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var bodyTextTV: UITextView!
    
    //MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTF.text, !title.isEmpty,
            let bodyText = bodyTextTV.text, !bodyText.isEmpty else { return }
        let isGoodDay = dayTypeSC.selectedSegmentIndex == 0
        if let entry = entry {
            EntryController.update(entry: entry, newTitle: title,newBodyText: bodyText, newIsGoodDay: isGoodDay)
        } else {
            EntryController.createEntryWith(title: title, bodyText: bodyText, isGoodDay: isGoodDay)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearTextButtonTapped(_ sender: UIButton) {
        titleTF.text = ""
        bodyTextTV.text = ""
    }
    
    //MARK: - Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = entry == nil ? "Add Entry" : "Edit Entry"
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let entry = entry else { return }
        dayTypeSC.selectedSegmentIndex = (entry.isGoodDay) ? (0) : (1)
        titleTF.text = entry.title
        bodyTextTV.text = entry.bodyText
    }
}
