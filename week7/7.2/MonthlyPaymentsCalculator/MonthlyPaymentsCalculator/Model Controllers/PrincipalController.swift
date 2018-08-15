//
//  PrincipalController.swift
//  MonthlyPaymentsCalculator
//
//  Created by Eric Lanza on 8/14/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

class PrincipalController {
    
    static let shared = PrincipalController()
    
    var principal: Principal?
    
    func createPrincipalWith(startAmount: Int, interestRate: Double, numberOfYears: Int){
        let principal = Principal(startAmount: startAmount, interestRate: interestRate, numberOfYears: numberOfYears)
        
        self.principal = principal
    }
    
    func calculateMonthlyPayment(for principal: Principal) -> Double {
        return (Double(principal.startAmount) + (Double(principal.startAmount) * (principal.interestRate * 0.01) * Double(principal.numberOfYears))) / Double(principal.numberOfYears * 12)
    }
}
