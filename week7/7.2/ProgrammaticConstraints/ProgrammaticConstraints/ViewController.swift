//
//  ViewController.swift
//  ProgrammaticConstraints
//
//  Created by Eric Lanza on 8/14/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let topLeftButton = UIButton()
    let topRightButton = UIButton()
    let bottomLeftButton = UIButton()
    let bottomRightButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
    }
    
    func setUpButtons() {
        view.addSubview(topLeftButton)
        view.addSubview(topRightButton)
        view.addSubview(bottomLeftButton)
        view.addSubview(bottomRightButton)
        
        topLeftButton.translatesAutoresizingMaskIntoConstraints = false
        topRightButton.translatesAutoresizingMaskIntoConstraints = false
        bottomLeftButton.translatesAutoresizingMaskIntoConstraints = false
        bottomRightButton.translatesAutoresizingMaskIntoConstraints = false
        
        topLeftButton.addTarget(self, action: #selector(changeColors), for: .touchUpInside)
        topRightButton.addTarget(self, action: #selector(changeColors), for: .touchUpInside)
        bottomLeftButton.addTarget(self, action: #selector(changeColors), for: .touchUpInside)
        bottomRightButton.addTarget(self, action: #selector(changeColors), for: .touchUpInside)
        
        topLeftButton.addTarget(self, action: #selector(buttonShake(sender:)), for: .touchDragExit)
        topRightButton.addTarget(self, action: #selector(buttonShake(sender:)), for: .touchDragExit)
        bottomLeftButton.addTarget(self, action: #selector(buttonShake(sender:)), for: .touchDragExit)
        bottomRightButton.addTarget(self, action: #selector(buttonShake(sender:)), for: .touchDragExit)
        
    
        //Top Left Button
        topLeftButton.backgroundColor = UIColor.red
        NSLayoutConstraint(item: topLeftButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: topLeftButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: topLeftButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: topLeftButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        
        //Top right Button
        topRightButton.backgroundColor = UIColor.blue
        NSLayoutConstraint(item: topRightButton, attribute: .leading, relatedBy: .equal, toItem: topLeftButton, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: topRightButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: topRightButton, attribute: .height, relatedBy: .equal, toItem: topLeftButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: topRightButton, attribute: .width, relatedBy: .equal, toItem: topLeftButton, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        // Bottom Left Button
        bottomLeftButton.backgroundColor = UIColor.yellow
        NSLayoutConstraint(item: bottomLeftButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomLeftButton, attribute: .top, relatedBy: .equal, toItem: topLeftButton, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomLeftButton, attribute: .height, relatedBy: .equal, toItem: topLeftButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomLeftButton, attribute: .width, relatedBy: .equal, toItem: topLeftButton, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        // Bottom Right Button
        bottomRightButton.backgroundColor = UIColor.cyan
        NSLayoutConstraint(item: bottomRightButton, attribute: .leading, relatedBy: .equal, toItem: bottomLeftButton, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomRightButton, attribute: .top, relatedBy: .equal, toItem: topRightButton, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomRightButton, attribute: .height, relatedBy: .equal, toItem: bottomLeftButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: bottomRightButton, attribute: .width, relatedBy: .equal, toItem: topRightButton, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
    }
    
    @objc func changeColors() {
        let topLeftColor = topLeftButton.backgroundColor
        let topRightColor = topRightButton.backgroundColor
        let bottomLeftColor = bottomLeftButton.backgroundColor
        let bottomRightColor = bottomRightButton.backgroundColor
        
        UIView.animate(withDuration: 1.0) {
            self.topLeftButton.backgroundColor = bottomLeftColor
            self.topRightButton.backgroundColor = topLeftColor
            self.bottomLeftButton.backgroundColor = bottomRightColor
            self.bottomRightButton.backgroundColor = topRightColor
        }
    }
    
    @objc func buttonShake(sender: UIButton) {
        view.bringSubview(toFront: sender)
        
        let baseValue = sender.frame.origin.x + sender.frame.width / 2
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [ baseValue, baseValue - 15, baseValue, baseValue + 15, baseValue]
        animation.keyTimes = [0.0, 0.25, 0.5, 0.75, 1]
        animation.duration = 1
        animation.repeatCount = 3
        
        sender.layer.add(animation, forKey: "shake")
    }
}
