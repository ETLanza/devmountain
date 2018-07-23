//
//  StarWarsCharacterDetailViewController.swift
//  StarWars
//
//  Created by Eric Lanza on 7/19/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class StarWarsCharacterDetailViewController: UIViewController {
    
    var character: StarWarsCharacter? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterBirthdateLabel: UILabel!
    @IBOutlet weak var characterForceSensitiveLabel: UILabel!
    @IBOutlet weak var characterAffilationLabel: UILabel!
    
    func updateViews() {
        guard let character = character else { return }
        characterImageView.image = UIImage(named: character.affiliation.lowercased())
        characterNameLabel.text = "\(character.firstName) \(character.lastName)"
        characterBirthdateLabel.text = character.birthdate
        characterForceSensitiveLabel.text = character.forceSensitive ? "Is Force Sensitive" : "Is not Force Sensitive"
        characterAffilationLabel.text = character.affiliation.uppercased()
    }
}
