//
//  NoteDetailViewController.swift
//  Notes
//
//  Created by Eric Lanza on 7/6/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
 
    //MARK: - IBOutlet
    @IBOutlet weak var bodyTextView: UITextView!
    
    //MARK: - IBAction
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let text = bodyTextView.text, text != "" else { return }
        if let note = self.note {
            NoteController.shared.updateNote(note, withBodyText: text)
        } else {
            NoteController.shared.addNote(Note.init(bodyText: text))
        }
        let _ = navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Properties
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if note != nil {
            bodyTextView.text = note?.bodyText
        }
    }
}
