//
//  CardViewController.swift
//  DeckOfCards
//
//  Created by Eric Lanza on 7/16/18.
//  Copyright © 2018 Frank Martin Jr. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var cardImageView: UIImageView!
    
    //MARK: - Actions
    @IBAction func drawCardButtonTapped(_ sender: UIButton) {
        let queue = DispatchQueue.global()
        queue.async {
            let deck = CardController.draw(numberOfCards: 1)
            guard let card = deck?.cards.first else { return }
            let imageURL = card.image
            let cardImage = CardController.getImage(urlAsString: imageURL)
            let main = DispatchQueue.main
            main.async {
                self.cardImageView.image = cardImage
            }
        }
        
    }
    
    
}
