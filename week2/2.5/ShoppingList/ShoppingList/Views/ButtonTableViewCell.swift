//
//  ButtonTableViewCell.swift
//  ProjectPlanning
//
//  Created by Eric Lanza on 7/11/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    //MARK: - Properties
    var delegate: ButtonTableViewCellDelegate?
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var primaryLabel: UILabel!
    
    //MARK: - Actions
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self)
    }
    
    //MARK: - Helper Methods
    func updateButton(_ isInCart: Bool) {
        let imageName = isInCart ? "complete" : "incomplete"
        completeButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
    }
    
}
//MARK: - Custom Delegate
protocol  ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}


