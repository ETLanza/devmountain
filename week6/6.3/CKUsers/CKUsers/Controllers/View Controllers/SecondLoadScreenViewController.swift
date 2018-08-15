//
//  SecondLoadScreenViewController.swift
//  CKUsers
//
//  Created by Eric Lanza on 8/8/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class SecondLoadScreenViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserController.shared.fetchUserFromCloudKit { (success) in
            if success {
                UserController.shared.fetchUserFromCloudKit { (success) in
                    if success {
                        EntryController.shared.fetchEntriesFromCloudKit(completion: { (success) in
                            DispatchQueue.main.async {
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let viewController = storyboard.instantiateViewController(withIdentifier: "entriesNC")
                                self.present(viewController, animated: true, completion: nil)
                            }
                        })
                    }
                }
            } else {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "signUpVC")
                    self.present(viewController, animated: true, completion: nil)
                }
            }
        }
    }
}


