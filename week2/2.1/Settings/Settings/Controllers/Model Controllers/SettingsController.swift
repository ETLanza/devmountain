//
//  SettingsController.swift
//  Settings
//
//  Created by Eric Lanza on 7/9/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class SettingsController {
    
    static let shared = SettingsController()
    
    var settings: [Setting] {
        
        let apps = Setting(name: "App Store", image: #imageLiteral(resourceName: "app"))
        let iTunes = Setting(name: "iTunes", image: #imageLiteral(resourceName: "itunes"))
        let iBooks = Setting(name: "iBooks", image: #imageLiteral(resourceName: "ibooks"))
        
        return [apps, iTunes, iBooks]
    }
    
    func isSetToggled(setting: Setting) {
        setting.isSet = !setting.isSet
    }
}
