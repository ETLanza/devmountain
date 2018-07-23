//
//  StarWarsCharacterTableViewCell.swift
//  StarWars
//
//  Created by Eric Lanza on 7/19/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class StarWarsCharacterTableViewCell: UITableViewCell {
    
    var character: StarWarsCharacter? {
        didSet {
            updateViews()
        }
    }
    
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    func updateViews() {
        guard let character = character else { return }
        characterImage.image = UIImage(named: character.affiliation.lowercased())
        characterName.text = "\(character.firstName) \(character.lastName)"
        
    }
    
}
