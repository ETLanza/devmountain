//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Eric Lanza on 7/11/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var entryBodyTextView: UITextView!
    @IBOutlet weak var clearButton: UIButton!
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
    }
    @IBOutlet weak var saveButtonPressed: UIBarButtonItem!
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
