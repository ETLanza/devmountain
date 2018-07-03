//
//  SignUpViewController.swift
//  ViewsAndStoryboards
//
//  Created by Eric Lanza on 7/2/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToWelcomeVC" {
            print("I did this part correctly")
            guard let destinationVC = segue.destination as? WelcomeViewController else { return print("This is where the bad stufff would happen")}
            print("This part worked too")
            destinationVC.name = nameTextField.text!
        }
    }
}
