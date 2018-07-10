//
//  ViewController.swift
//  AlertGame
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let beginningAlertController = UIAlertController(title: "Find the queen", message: nil, preferredStyle: .alert)
        
        let winningAlertController = UIAlertController(title: "You won!", message: nil, preferredStyle: .alert)
        
        let losingAlertController = UIAlertController(title: "Sorry, you lose.", message: nil, preferredStyle: .alert)
        
        
        
        let queenAction = UIAlertAction(title: "1", style: .default) { (alert) in
                self.present(winningAlertController, animated: true, completion: nil)
        }
        
        let secondAction = UIAlertAction(title: "2", style: .default) { (alert) in
            self.present(losingAlertController, animated: true, completion: nil)
        }
        
        let thirdAcrtion = UIAlertAction(title: "3", style: .default) { (alert) in
            self.present(losingAlertController, animated: true, completion: nil)
        }
        
        
        beginningAlertController.addAction(queenAction)
        beginningAlertController.addAction(secondAction)
        beginningAlertController.addAction(thirdAcrtion)
        
        let playAgainAction = UIAlertAction(title: "Play again!", style: .default) { (alert) in
            self.present(beginningAlertController, animated: true, completion: nil)
        }
        
        
        winningAlertController.addAction(playAgainAction)
        losingAlertController.addAction(playAgainAction)
        
        self.present(beginningAlertController, animated: true, completion: nil)
        
    }

}

