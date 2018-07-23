//
//  RepresentativeTableViewCell.swift
//  Representatives
//
//  Created by Eric Lanza on 7/19/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class RepresentativeTableViewCell: UITableViewCell {
    
    var rep: Representative? {
        didSet {
            updateViews()
        }
    }
    
    var state: String?

    @IBOutlet weak var repNameLabel: UILabel!
    @IBOutlet weak var repPartyLabel: UILabel!
    @IBOutlet weak var repDistrictLabel: UILabel!
    @IBOutlet weak var repWebsiteLabel: UILabel!
    @IBOutlet weak var repPhoneNumberLabel: UILabel!
    
    func updateViews() {
        guard let rep = rep else { return }
        repNameLabel.text = rep.name
        repPartyLabel.text = rep.party
        repDistrictLabel.text = rep.district
        repWebsiteLabel.text = rep.link
        repPhoneNumberLabel.text = rep.phone
    }
    
}
