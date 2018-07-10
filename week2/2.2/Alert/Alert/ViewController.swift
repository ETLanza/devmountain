//
//  ViewController.swift
//  Alert
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let alertController = UIAlertController(title: "Alert!", message: "This is an alert. ", preferredStyle: .alert)
        
        let destructiveAction = UIAlertAction(title: "Warning!", style: .destructive) { (alert) in
            print("Something blew up!")
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (alert) in
            print("Default")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            print("Cancel")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        alertController.addAction(destructiveAction)
        
        self.present(alertController, animated: true, completion: nil)

    }
    
}

