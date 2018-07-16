//
//  RestaurantTableViewCell.swift
//  RestaurantRater
//
//  Created by Eric Lanza on 7/14/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

protocol RestaurantTableViewCellDelegate: class {
    func thumbsUpDownButtonTapped(_ sender: RestaurantTableViewCell)
}

class RestaurantTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var restaurant: Restaurant? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: RestaurantTableViewCellDelegate?
    
    //MARK: - Outlets
    @IBOutlet weak var thumbUpDownButton: UIButton!
    @IBOutlet weak var restaurantLabel: UILabel!
    
    //MARK: - Actions
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.thumbsUpDownButtonTapped(self)
    }
    
    func updateViews() {
        guard let restaurant = restaurant else { return }
        
        restaurantLabel.text = restaurant.name
        
        let image = restaurant.isGood ? UIImage(named: "thumbs-up") : UIImage(named: "thumbs-down")
        thumbUpDownButton.setImage(image, for: .normal)
    }
    
}

