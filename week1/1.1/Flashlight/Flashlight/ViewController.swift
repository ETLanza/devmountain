//
//  ViewController.swift
//  Flashlight
//
//  Created by Eric Lanza on 7/2/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var toggleButton: UIButton!
    
    let gestureRecognizer = UISwipeGestureRecognizer()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isOn {
            return .default
        } else {
            return .lightContent
        }
    }
    
    var isOn: Bool {
        if view.backgroundColor == UIColor.white {
            return true
        } else {
            return false
        }
    }
    
    func toggleFlashlight() {
        if isOn {
            view.backgroundColor = UIColor.black
            toggleButton.setTitle("On", for: .normal)
            toggleButton.setTitleColor(UIColor.white, for: .normal)
            toggleTorch(on: false)
        } else {
            view.backgroundColor = UIColor.white
            toggleButton.setTitle("Off", for: .normal)
            toggleButton.setTitleColor(UIColor.black, for: .normal)
            toggleTorch(on: true)
        }
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is unavailable")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        toggleFlashlight()
    }
    
    @IBAction func swippedLeft(_ sender: UISwipeGestureRecognizer) {
        if isOn {
            toggleFlashlight()
        }
    }
    
    @IBAction func swippedRight(_ sender: UISwipeGestureRecognizer) {
        if !isOn {
            toggleFlashlight()
        }
    }
}

