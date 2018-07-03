//
//  DetailViewController.swift
//  ViewsAndStoryboards
//
//  Created by Eric Lanza on 7/2/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBAction func touchUpInside(_ sender: UIButton) {
        view.backgroundColor = UIColor.red
    }
    @IBAction func touchUpOutside(_ sender: Any) {
        view.backgroundColor = UIColor.blue
    }
    @IBAction func touchDown(_ sender: UIButton) {
        view.backgroundColor = UIColor.orange
    }
    @IBAction func touchDragExit(_ sender: UIButton) {
        view.backgroundColor = UIColor.green
    }
    @IBAction func touchDragInside(_ sender: UIButton) {
        view.backgroundColor = UIColor.gray
    }
    @IBAction func touchDragEnter(_ sender: UIButton) {
        view.backgroundColor = UIColor.yellow
    }
    
    
    
    
    
    

}
