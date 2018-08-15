//
//  CalculateViewController.swift
//  MonthlyPaymentsCalculator
//
//  Created by Eric Lanza on 8/14/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    //MARK: - Properties
    let oneLabel = UILabel()
    let loanAmountLabel = UILabel()
    let loanAmountTextField = UITextField()
    let twoLabel = UILabel()
    let interestRateLabel = UILabel()
    let interestRateTextField = UITextField()
    let threeLabel = UILabel()
    let numberOfYearsLabel = UILabel()
    let numberOfYearsTextField = UITextField()
    let calculateButton = UIButton()
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "midnight")
        navigationController?.navigationBar.isHidden = true
        setUpViews()
    }
    
    //MARK: - Helper Methods
    func setUpViews() {
        loanAmountView()
        interestRateView()
        numberOfYearsView()
        calculateButtonView()
    }
    
    //MARK: - Loan Amount View
    func loanAmountView() {
        view.addSubview(oneLabel)
        view.addSubview(loanAmountLabel)
        view.addSubview(loanAmountTextField)
        
        oneLabel.translatesAutoresizingMaskIntoConstraints = false
        loanAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        loanAmountTextField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: One Label
        oneLabel.backgroundColor = UIColor(named: "darkendTeal")
        oneLabel.text = "1"
        oneLabel.font = UIFont(name: oneLabel.font.fontName, size: 30)
        oneLabel.textColor = UIColor.white
        oneLabel.textAlignment = .center
        oneLabel.layer.cornerRadius = view.frame.width * Constant.numberLabelMultiplier / 2
        oneLabel.clipsToBounds = true
        
        
        NSLayoutConstraint(item: oneLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: oneLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 64).isActive = true
        NSLayoutConstraint(item: oneLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: Constant.numberLabelMultiplier, constant: 0).isActive = true
        NSLayoutConstraint(item: oneLabel, attribute: .height, relatedBy: .equal, toItem: oneLabel, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
    
        //MARK: Loan Amount Label
        loanAmountLabel.text = "Loan Amount"
        loanAmountLabel.textColor = UIColor.white
        loanAmountLabel.font = UIFont(name: loanAmountLabel.font.fontName, size: 20)
        loanAmountLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint(item: loanAmountLabel, attribute: .leading, relatedBy: .equal, toItem: oneLabel, attribute: .trailing, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint(item: loanAmountLabel, attribute: .top, relatedBy: .equal, toItem: oneLabel, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: loanAmountLabel, attribute: .height, relatedBy: .equal, toItem: oneLabel, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: loanAmountLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: Constant.textLabelMultiplier, constant: 0).isActive = true
        
        //MARK: Loan Amount TextField
        loanAmountTextField.placeholder = "Enter $..."
        loanAmountTextField.keyboardType = .numberPad
        loanAmountTextField.textColor = UIColor.white
        loanAmountTextField.textAlignment = .center
        loanAmountTextField.backgroundColor = UIColor.lightGray
        loanAmountTextField.font = UIFont(name: loanAmountLabel.font.fontName, size: 20)
        loanAmountTextField.layer.cornerRadius = 10
        loanAmountTextField.clipsToBounds = true
        
        NSLayoutConstraint(item: loanAmountTextField, attribute: .leading, relatedBy: .equal, toItem: loanAmountLabel, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: loanAmountTextField, attribute: .top, relatedBy: .equal, toItem: loanAmountLabel, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: loanAmountTextField, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: Constant.textFieldMultiplier, constant: 0).isActive = true
        NSLayoutConstraint(item: loanAmountTextField, attribute: .height, relatedBy: .equal, toItem: loanAmountLabel, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    }
    
    //MARK: - Interest Rate View
    func interestRateView() {
        view.addSubview(twoLabel)
        view.addSubview(interestRateLabel)
        view.addSubview(interestRateTextField)
        
        twoLabel.translatesAutoresizingMaskIntoConstraints = false
        interestRateLabel.translatesAutoresizingMaskIntoConstraints = false
        interestRateTextField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Two Label
        twoLabel.backgroundColor = UIColor(named: "darkendTeal")
        twoLabel.text = "2"
        twoLabel.font = UIFont(name: oneLabel.font.fontName, size: 30)
        twoLabel.textColor = UIColor.white
        twoLabel.textAlignment = .center
        twoLabel.layer.cornerRadius = view.frame.width * Constant.numberLabelMultiplier / 2
        twoLabel.clipsToBounds = true
        
        NSLayoutConstraint(item: twoLabel, attribute: .leading, relatedBy: .equal, toItem: oneLabel, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: twoLabel, attribute: .top, relatedBy: .equal, toItem: oneLabel, attribute: .bottom, multiplier: 1.0, constant: 64).isActive = true
        NSLayoutConstraint(item: twoLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: Constant.numberLabelMultiplier, constant: 0).isActive = true
        NSLayoutConstraint(item: twoLabel, attribute: .height, relatedBy: .equal, toItem: twoLabel, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        //MARK: Interest Rate Label
        interestRateLabel.text = "Interest Rate"
        interestRateLabel.textColor = UIColor.white
        interestRateLabel.font = UIFont(name: interestRateLabel.font.fontName, size: 20)
        interestRateLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint(item: interestRateLabel, attribute: .leading, relatedBy: .equal, toItem: twoLabel, attribute: .trailing, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint(item: interestRateLabel, attribute: .top, relatedBy: .equal, toItem: twoLabel, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: interestRateLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: Constant.textLabelMultiplier, constant: 0).isActive = true
        NSLayoutConstraint(item: interestRateLabel, attribute: .height, relatedBy: .equal, toItem: twoLabel, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        
        //MARK: Interest Rate TextField
        interestRateTextField.placeholder = "Enter %..."
        interestRateTextField.keyboardType = .decimalPad
        interestRateTextField.textColor = UIColor.white
        interestRateTextField.textAlignment = .center
        interestRateTextField.backgroundColor = UIColor.lightGray
        interestRateTextField.font = UIFont(name: interestRateLabel.font.fontName, size: 20)
        interestRateTextField.layer.cornerRadius = 10
        interestRateTextField.clipsToBounds = true
        
        NSLayoutConstraint(item: interestRateTextField, attribute: .leading, relatedBy: .equal, toItem: interestRateLabel, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: interestRateTextField, attribute: .top, relatedBy: .equal, toItem: interestRateLabel, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: interestRateTextField, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: Constant.textFieldMultiplier, constant: 0).isActive = true
        NSLayoutConstraint(item: interestRateTextField, attribute: .height, relatedBy: .equal, toItem: interestRateLabel, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        
    }
    
    //MARK: - Number Of Years View
    func numberOfYearsView() {
        view.addSubview(threeLabel)
        view.addSubview(numberOfYearsLabel)
        view.addSubview(numberOfYearsTextField)
        
        threeLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfYearsLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfYearsTextField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Three Label
        threeLabel.backgroundColor = UIColor(named: "darkendTeal")
        threeLabel.text = "3"
        threeLabel.font = UIFont(name: oneLabel.font.fontName, size: 30)
        threeLabel.textColor = UIColor.white
        threeLabel.textAlignment = .center
        threeLabel.layer.cornerRadius = view.frame.width * Constant.numberLabelMultiplier / 2
        threeLabel.clipsToBounds = true
        
        NSLayoutConstraint(item: threeLabel, attribute: .leading, relatedBy: .equal, toItem: twoLabel, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: threeLabel, attribute: .top, relatedBy: .equal, toItem: twoLabel, attribute: .bottom, multiplier: 1.0, constant: 64).isActive = true
        NSLayoutConstraint(item: threeLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: Constant.numberLabelMultiplier, constant: 0).isActive = true
        NSLayoutConstraint(item: threeLabel, attribute: .height, relatedBy: .equal, toItem: threeLabel, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        //MARK: Number of Years Label
        numberOfYearsLabel.text = "Number Of Years"
        numberOfYearsLabel.textColor = UIColor.white
        numberOfYearsLabel.font = UIFont(name: numberOfYearsLabel.font.fontName, size: 20)
        numberOfYearsLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint(item: numberOfYearsLabel, attribute: .leading, relatedBy: .equal, toItem: threeLabel, attribute: .trailing, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint(item: numberOfYearsLabel, attribute: .top, relatedBy: .equal, toItem: threeLabel, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: numberOfYearsLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: Constant.textLabelMultiplier, constant: 0).isActive = true
        NSLayoutConstraint(item: numberOfYearsLabel, attribute: .height, relatedBy: .equal, toItem: threeLabel, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        
        //MARK: Number of years Text Field
        numberOfYearsTextField.placeholder = "Enter Years..."
        numberOfYearsTextField.keyboardType = .numberPad
        numberOfYearsTextField.textColor = UIColor.white
        numberOfYearsTextField.textAlignment = .center
        numberOfYearsTextField.backgroundColor = UIColor.lightGray
        numberOfYearsTextField.font = UIFont(name: numberOfYearsLabel.font.fontName, size: 20)
        numberOfYearsTextField.layer.cornerRadius = 10
        numberOfYearsTextField.clipsToBounds = true
        
        NSLayoutConstraint(item: numberOfYearsTextField, attribute: .leading, relatedBy: .equal, toItem: numberOfYearsLabel, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: numberOfYearsTextField, attribute: .top, relatedBy: .equal, toItem: numberOfYearsLabel, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: numberOfYearsTextField, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: Constant.textFieldMultiplier, constant: 0).isActive = true
        NSLayoutConstraint(item: numberOfYearsTextField, attribute: .height, relatedBy: .equal, toItem: numberOfYearsLabel, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
    }
    
    //MARK: - Calculate Button View
    func calculateButtonView() {
        view.addSubview(calculateButton)
        
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        
        calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.backgroundColor = UIColor(named: "darkendTeal")
        calculateButton.titleEdgeInsets = UIEdgeInsets(top: 6.0, left: 8.0, bottom: 6.0, right: 8.0)
        calculateButton.setTitleColor(UIColor.white, for: .normal)
        calculateButton.layer.cornerRadius = 5
        calculateButton.clipsToBounds = true
        
        NSLayoutConstraint(item: calculateButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: calculateButton, attribute: .top, relatedBy: .equal, toItem: numberOfYearsLabel, attribute: .bottom, multiplier: 1.0, constant: 64).isActive = true
        NSLayoutConstraint(item: calculateButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
    }
    
    //MARK: - Calculate Button Tapped
    @objc func calculateButtonTapped() {
        guard let startAmountAsString = loanAmountTextField.text, !startAmountAsString.isEmpty,
            let startAmount = Int(startAmountAsString),
            let interestRateAsString = interestRateTextField.text, !interestRateAsString.isEmpty,
            let interestRate = Double(interestRateAsString),
            let numberOfYearsAsString = numberOfYearsTextField.text, !numberOfYearsAsString.isEmpty,
            let numberOfYears = Int(numberOfYearsAsString) else { displayMissingInfoAlert(); return }
        
        let paymentVC = MonthlyPaymentViewController()
        PrincipalController.shared.createPrincipalWith(startAmount: startAmount, interestRate: interestRate, numberOfYears: numberOfYears)
        paymentVC.principal = PrincipalController.shared.principal
    
        paymentVC.modalPresentationStyle = .overCurrentContext
        paymentVC.modalTransitionStyle = .crossDissolve
    
        present(paymentVC, animated: true, completion: nil)
    }
    
    func displayMissingInfoAlert() {
        let alertController = UIAlertController(title: "Missing Info", message: "Make sure all fields are filled out!", preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alertController.addAction(okayAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
