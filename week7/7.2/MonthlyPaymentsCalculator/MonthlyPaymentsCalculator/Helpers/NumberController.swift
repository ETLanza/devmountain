//
//  NumberController.swift
//  MonthlyPaymentsCalculator
//
//  Created by Eric Lanza on 8/15/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class NumberController {
    
    let currencyFormatter = NumberFormatter()
    let decimalFormatter = NumberFormatter()
    let defaultFormatter = NumberFormatter()
    
    init(){
        currencyFormatter.currencySymbol = "$"
        currencyFormatter.minimumFractionDigits = 2
        currencyFormatter.groupingSeparator = ","
        currencyFormatter.numberStyle = .currency
        
        decimalFormatter.maximumFractionDigits = 2
        decimalFormatter.minimumFractionDigits = 2
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.numberStyle = .decimal
        
        defaultFormatter.numberStyle = .decimal
        defaultFormatter.groupingSeparator = ","
        defaultFormatter.maximumFractionDigits = 0
        defaultFormatter.currencySymbol = "$"
        defaultFormatter.alwaysShowsDecimalSeparator = false
    }
}
