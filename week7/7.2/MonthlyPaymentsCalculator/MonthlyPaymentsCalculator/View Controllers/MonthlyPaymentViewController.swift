//
//  MonthlyPaymentViewController.swift
//  MonthlyPaymentsCalculator
//
//  Created by Eric Lanza on 8/14/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class MonthlyPaymentViewController: UIViewController {
    
    //MARK: - Number Formatter
    let numberFormatter = NumberController()
    
    //MARK: - Properties
    let containerView = UIView()
    let loanAmountTextLabel = UILabel()
    let loanAmountValueLabel = UILabel()
    let interestRateTextLabel = UILabel()
    let interestRateSlider = UISlider()
    let interestRateValueLabel = UILabel()
    let numberOfYearsTextLabel = UILabel()
    let numberOfYearsValueLabel = UILabel()
    let monthlyPaymentsTextLabel = UILabel()
    let monthlyPaymentsValueLabel = UILabel()
    let closeButton = UIButton()
    
    var principal: Principal?
    


    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "seethroughBlack")
        setUpViews()
    }
    
    //MARK: - Helper Functions
    func setUpViews() {
        containerViewSetup()
        loanAmountView()
        interestRateView()
        numberOfYearsView()
        monthlyPaymentView()
        closeButtonView()
        guard let principal = principal else { return }
        let payment = NSNumber(value: PrincipalController.shared.calculateMonthlyPayment(for: principal))
        let loanAmount = NSNumber(value: principal.startAmount)
        loanAmountValueLabel.text = "$\(numberFormatter.defaultFormatter.string(from: loanAmount)!)"
        interestRateValueLabel.text = "\(principal.interestRate)%"
        interestRateSlider.value = Float(principal.interestRate)
        numberOfYearsValueLabel.text = "\(principal.numberOfYears) Years"
        monthlyPaymentsValueLabel.text = "\(numberFormatter.currencyFormatter.string(from: payment)!)"
    }
    
    //MARK: - Container View
    func containerViewSetup() {
        view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = UIColor(named: "midnight")
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        
        NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.6, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.8, constant: 0).isActive = true
    }
    
    //MARK: - Loan Amount View
    func loanAmountView() {
        containerView.addSubview(loanAmountTextLabel)
        containerView.addSubview(loanAmountValueLabel)
        
        loanAmountTextLabel.translatesAutoresizingMaskIntoConstraints = false
        loanAmountValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        loanAmountTextLabel.text = "Loan Amount"
        loanAmountTextLabel.font = UIFont(name: loanAmountTextLabel.font.fontName, size: 30)
        loanAmountTextLabel.textColor = UIColor.white
        loanAmountTextLabel.textAlignment = .center
        
        NSLayoutConstraint(item: loanAmountTextLabel, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: loanAmountTextLabel, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: loanAmountTextLabel, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.7, constant: 0).isActive = true
        
        loanAmountValueLabel.textAlignment = .center
        loanAmountValueLabel.font = UIFont(name: loanAmountValueLabel.font.fontName, size: 20)
        loanAmountValueLabel.textColor = UIColor.white
        
        NSLayoutConstraint(item: loanAmountValueLabel, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: loanAmountValueLabel, attribute: .top, relatedBy: .equal, toItem: loanAmountTextLabel, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint(item: loanAmountValueLabel, attribute: .width, relatedBy: .equal, toItem: loanAmountTextLabel, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
    }
    
    //MARK: - Interest Rate View
    func interestRateView() {
        containerView.addSubview(interestRateTextLabel)
        containerView.addSubview(interestRateSlider)
        containerView.addSubview(interestRateValueLabel)
        
        interestRateTextLabel.translatesAutoresizingMaskIntoConstraints = false
        interestRateSlider.translatesAutoresizingMaskIntoConstraints = false
        interestRateValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        interestRateTextLabel.text = "Interest Rate"
        interestRateTextLabel.font = UIFont(name: interestRateTextLabel.font.fontName, size: 30)
        interestRateTextLabel.textColor = UIColor.white
        interestRateTextLabel.textAlignment = .center
        
        NSLayoutConstraint(item: interestRateTextLabel, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: interestRateTextLabel, attribute: .top, relatedBy: .equal, toItem: loanAmountValueLabel, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: interestRateTextLabel, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.7, constant: 0).isActive = true
        
        interestRateSlider.maximumValue = 30.0
        interestRateSlider.minimumValue = 0.0
        interestRateSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        NSLayoutConstraint(item: interestRateSlider, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: interestRateSlider, attribute: .top, relatedBy: .equal, toItem: interestRateTextLabel, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint(item: interestRateSlider, attribute: .width, relatedBy: .equal, toItem: interestRateTextLabel, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        
        interestRateValueLabel.textAlignment = .center
        interestRateValueLabel.font = UIFont(name: interestRateValueLabel.font.fontName, size: 20)
        interestRateValueLabel.textColor = UIColor.white
        
        NSLayoutConstraint(item: interestRateValueLabel, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: interestRateValueLabel, attribute: .top, relatedBy: .equal, toItem: interestRateSlider, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint(item: interestRateValueLabel, attribute: .width, relatedBy: .equal, toItem: interestRateTextLabel, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
    }
    
    func numberOfYearsView() {
        containerView.addSubview(numberOfYearsTextLabel)
        containerView.addSubview(numberOfYearsValueLabel)
        
        numberOfYearsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfYearsValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numberOfYearsTextLabel.text = "Length of Loan"
        numberOfYearsTextLabel.font = UIFont(name: numberOfYearsTextLabel.font.fontName, size: 30)
        numberOfYearsTextLabel.textColor = UIColor.white
        numberOfYearsTextLabel.textAlignment = .center
        
        NSLayoutConstraint(item: numberOfYearsTextLabel, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: numberOfYearsTextLabel, attribute: .top, relatedBy: .equal, toItem: interestRateValueLabel, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: numberOfYearsTextLabel, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.7, constant: 0).isActive = true
        
        numberOfYearsValueLabel.textAlignment = .center
        numberOfYearsValueLabel.font = UIFont(name: numberOfYearsValueLabel.font.fontName, size: 20)
        numberOfYearsValueLabel.textColor = UIColor.white
        
        NSLayoutConstraint(item: numberOfYearsValueLabel, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: numberOfYearsValueLabel, attribute: .top, relatedBy: .equal, toItem: numberOfYearsTextLabel, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint(item: numberOfYearsValueLabel, attribute: .width, relatedBy: .equal, toItem: numberOfYearsTextLabel, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
    }
    
    //MARK: - Monthly Payment View
    func monthlyPaymentView() {
        containerView.addSubview(monthlyPaymentsTextLabel)
        containerView.addSubview(monthlyPaymentsValueLabel)
        
        monthlyPaymentsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        monthlyPaymentsValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        monthlyPaymentsTextLabel.text = "Monthly Payments"
        monthlyPaymentsTextLabel.font = UIFont(name: monthlyPaymentsTextLabel.font.fontName, size: 30)
        monthlyPaymentsTextLabel.textColor = UIColor.white
        monthlyPaymentsTextLabel.textAlignment = .center
        
        NSLayoutConstraint(item: monthlyPaymentsTextLabel, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: monthlyPaymentsTextLabel, attribute: .top, relatedBy: .equal, toItem: numberOfYearsValueLabel, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: monthlyPaymentsTextLabel, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.9, constant: 0).isActive = true
        
        monthlyPaymentsValueLabel.textAlignment = .center
        monthlyPaymentsValueLabel.font = UIFont(name: monthlyPaymentsValueLabel.font.fontName, size: 20)
        monthlyPaymentsValueLabel.textColor = UIColor.white
        
        NSLayoutConstraint(item: monthlyPaymentsValueLabel, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: monthlyPaymentsValueLabel, attribute: .top, relatedBy: .equal, toItem: monthlyPaymentsTextLabel, attribute: .bottom, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint(item: monthlyPaymentsValueLabel, attribute: .width, relatedBy: .equal, toItem: monthlyPaymentsTextLabel, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
    }
    
    //MARK: - Close Button View
    func closeButtonView() {
        containerView.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.setTitle("Close", for: .normal)
        closeButton.backgroundColor = UIColor(named: "darkendTeal")
        closeButton.setTitleColor(UIColor.white, for: .normal)
        closeButton.titleEdgeInsets = UIEdgeInsets(top: 6.0, left: 8.0, bottom: 6.0, right: 8.0)
        closeButton.layer.cornerRadius = 5
        closeButton.clipsToBounds = true
        
        NSLayoutConstraint(item: closeButton, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: monthlyPaymentsValueLabel, attribute: .bottom, multiplier: 1.0, constant: 16).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.7, constant: 0).isActive = true

        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Methods
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func sliderValueChanged() {
        guard let principal = principal else { return }
        
        let number = interestRateSlider.value
        let preFormattedNumber = NSNumber(value: number)
        
        guard let value = numberFormatter.decimalFormatter.string(from: preFormattedNumber) else { return }
        
        let payment = NSNumber(value: PrincipalController.shared.calculateMonthlyPayment(for: principal))
        
        guard let paymentValue = numberFormatter.currencyFormatter.string(from: payment) else { return }
        principal.interestRate = Double(truncating: preFormattedNumber)
        interestRateValueLabel.text = "\(value)%"
        monthlyPaymentsValueLabel.text = "\(paymentValue)"
    }
}
