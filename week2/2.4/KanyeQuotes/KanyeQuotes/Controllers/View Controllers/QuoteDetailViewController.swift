//
//  QuoteDetailViewController.swift
//  KanyeQuotes
//
//  Created by Eric Lanza on 7/12/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class QuoteDetailViewController: UIViewController {

    var quote: Quote?
    
    @IBOutlet weak var quoteTextLabel: UILabel!
    @IBOutlet weak var yesNoLabel: UILabel!
    @IBOutlet weak var happySadKanyeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let quote = quote {
            happySadKanyeImageView.image = quote.isKanye ? #imageLiteral(resourceName: "happyKanye") : #imageLiteral(resourceName: "sadKanye")
            yesNoLabel.text = quote.isKanye ? "Yes" : "No"
            yesNoLabel.textColor = quote.isKanye ? UIColor.green : UIColor.red
            quoteTextLabel.text = quote.text
        }
    }
    
}
