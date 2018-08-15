//
//  ViewController.swift
//  PopUpMarkM
//
//  Created by Eric Lanza on 8/10/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet weak var timeDateLabel: UILabel!
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let formatter = DateFormatter()
        
        if segue.identifier == "datePickerSegue" {
            weak var destinationVC = segue.destination as? PopUpViewController
            destinationVC?.showTimePicker = false
            formatter.dateStyle = .medium
            destinationVC?.onSave = { //[weak destinationVC] in
                self.timeDateLabel.text = formatter.string(from: destinationVC!.datePicker.date)
            }
        }
        
        if segue.identifier == "timePickerSegue" {
            let destinationVC = segue.destination as! PopUpViewController
            destinationVC.showTimePicker = true
            formatter.timeStyle = .medium
            destinationVC.onSave = { [weak self, weak destinationVC] in
                self?.timeDateLabel.text = formatter.string(from: destinationVC!.datePicker.date)
            }
        }
    }
}
