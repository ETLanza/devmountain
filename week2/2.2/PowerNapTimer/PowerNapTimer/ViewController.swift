//
//  ViewController.swift
//  PowerNapTimer
//
//  Created by Eric Lanza on 7/10/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    var myTimer = MyTimer()
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    //MARK: - Actions
    @IBAction func startStopButtonPressed(_ sender: UIButton) {
        if myTimer.isOn {
            myTimer.stopTimer()
        } else {
            myTimer.startTimer(5)
        }
    }
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        myTimer.delegate = self
    }
}

//MARK: - MyTimeDelegate Protocol Methods
extension ViewController: MyTimerDelegate {
    func timerSecondTicked() {
        updateButtonAndLabel()
    }
    
    func timerCompleted() {
        updateButtonAndLabel()
        displayAlert()
    }
    
    func timerStopped() {
        updateButtonAndLabel()
    }
    
    func updateButtonAndLabel() {
        var buttonTitle: String
        if myTimer.isOn {
            buttonTitle = "Stop Nap"
        } else {
            buttonTitle = "Start Nap"
        }
        startStopButton.setTitle(buttonTitle, for: .normal)
        timerLabel.text = myTimer.timeLeftAsString()
    }
}

//MARK: - Alert Controller Method
extension ViewController {
    
    func displayAlert() {
        let alert = UIAlertController(title: "Time to wake up!", message: "Or Snooze", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Snooze for how many more minutes..."
            textField.keyboardType = .numberPad
        }
        
        
        let okButton = UIAlertAction(title: "I'm Up", style: .default, handler: nil)
        alert.addAction(okButton)
        
        let snoozeButton = UIAlertAction(title: "Snooze", style: .destructive) { (_) in
            let textField = alert.textFields!.first!
            let timeAsString = textField.text!
            let timeAsDouble = Double(timeAsString)! * 60.0
            self.myTimer.startTimer(timeAsDouble)
        }
        alert.addAction(snoozeButton)
        present(alert, animated: true, completion: nil)
    }
}
