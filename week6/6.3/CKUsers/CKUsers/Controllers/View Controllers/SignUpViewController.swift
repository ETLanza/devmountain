//
//  SignUpViewController.swift
//  CKUsers
//
//  Created by Eric Lanza on 8/8/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    //MARK: - IBActions
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty else { return }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        UserController.shared.createNewUserWith(username: username, firstName: firstName, lastName: lastName) { (success) in
            if success {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "entriesNC")
                    self.present(viewController, animated: true, completion: nil)
                }
            }
        }
    }
    
}
