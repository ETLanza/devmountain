//
//  ViewController.swift
//  iTunes Search App
//
//  Created by Eric Lanza on 7/16/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBAction func searchPressed(_ sender: UIButton) {
        guard let term = searchTextField.text else { return }
        
        SearchResultsController.serchResultsForSearhTerm(searchTerm: term) { [weak self] (results) in
            if let results = results, let first = results.first {
                DispatchQueue.main.async {
                    self?.resultsLabel.text = "\(first.trackName) - \(first.artistName)"
                }
            }
        }
        
    }
    @IBOutlet weak var resultsLabel: UILabel!
    
    
}

