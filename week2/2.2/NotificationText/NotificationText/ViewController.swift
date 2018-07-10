//
//  ViewController.swift
//  NotificationText
//
//  Created by Eric Lanza on 7/10/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let notificationManager = NotificationManager()
    
    @IBAction func requestPermission(_ sender: UIButton) {
        notificationManager.requestPermission()
    }
    
    @IBAction func sendNotification(_ sender: UIButton) {
        notificationManager.fireNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("localNotificationFired"), object: nil, queue: OperationQueue.main) { [weak self] (note) in
            guard let userInfo = note.userInfo,
                let message = userInfo["message"] as? String else { return }
            
            let alert = UIAlertController(title: "Local Notification", message: message, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancel)
            DispatchQueue.main.async {
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
}

