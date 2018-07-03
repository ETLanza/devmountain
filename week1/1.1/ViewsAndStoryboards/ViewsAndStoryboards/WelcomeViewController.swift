//
//  WelcomeViewController.swift
//  ViewsAndStoryboards
//
//  Created by Eric Lanza on 7/2/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet var welcomeLabel: UILabel!
    var name: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        welcomeLabel.text = "Welcome, \(name)!"
    }
}
