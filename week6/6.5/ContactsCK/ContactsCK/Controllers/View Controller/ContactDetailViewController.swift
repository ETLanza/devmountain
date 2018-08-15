//
//  ContactDetailViewController.swift
//  ContactsCK
//
//  Created by Eric Lanza on 8/10/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    //MARK: - Properties
    var contact: Contact? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    //MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else { return }
        if let contact = contact {
            ContactController.shared.update(contact: contact, withName: name, phoneNumber: phoneNumberTextField.text, emailAddress: emailAddressTextField.text) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            ContactController.shared.createNewContactWith(name: name, phoneNumber: phoneNumberTextField.text, emailAddress: emailAddressTextField.text) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        if let contact = contact {
            self.title = "Edit Contact"
            nameTextField.text = contact.name
            phoneNumberTextField.text = contact.phoneNumber
            emailAddressTextField.text = contact.emailAddress
        } else {
            nameTextField.text = ""
            phoneNumberTextField.text = ""
            emailAddressTextField.text = ""
        }
    }
}
