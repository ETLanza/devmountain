//
//  CardViewController.swift
//  DeckOFOneCardObjectiveC
//
//  Created by Eric Lanza on 7/24/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardSuitLabel: UILabel!
    @IBAction func drawNewCardButtonPressed(_ sender: UIButton) {
        DVMCardController.shared().drawANewCard(1) { (card, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let firstCard = card?.first else { return }
            DVMCardController.shared().fetchCardImage(for: firstCard, completion: { (image) in
                DispatchQueue.main.async {
                    self.cardImageView.image = image
                }
            })
            DispatchQueue.main.async {
                self.cardSuitLabel.text = firstCard.suit
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
