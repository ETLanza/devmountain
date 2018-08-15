//
//  Principal.swift
//  MonthlyPaymentsCalculator
//
//  Created by Eric Lanza on 8/14/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class Principal {
    let startAmount: Int
    var interestRate: Double
    let numberOfYears: Int
    
    init(startAmount: Int, interestRate: Double, numberOfYears: Int) {
        self.startAmount = startAmount
        self.interestRate = interestRate
        self.numberOfYears = numberOfYears
    }
}
