//
//  MyTimer.swift
//  PowerNapTimer
//
//  Created by Eric Lanza on 7/10/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import Foundation

protocol MyTimerDelegate: class {
    func timerSecondTicked()
    func timerCompleted()
    func timerStopped()
}

class MyTimer {
    
    //MARK: - Properties
    private var timer: Timer?
    var timeLeft: TimeInterval?
    var isOn: Bool {
        return timeLeft == nil ? false : true
    }
    
    weak var delegate: MyTimerDelegate?
    
    //MARK: - Methods
    func startTimer(_ time: TimeInterval) {
        if !isOn {
            timeLeft = time
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                self.secondTick()
            })
        } else {
            print("The timer is alreayd on")
        }
    }
    
    func stopTimer() {
        if isOn {
            timeLeft = nil
            timer?.invalidate()
        } else {
            print("The timer was already off")
        }
        delegate?.timerStopped()
    }
    
    func timeLeftAsString() -> String {
        let timeRemaining = Int(self.timeLeft ?? 20*60)
        let minutesLeft = timeRemaining / 60
        let secondsLeft = timeRemaining - (minutesLeft * 60)
        return String(format: "%02d:%02d", arguments: [minutesLeft, secondsLeft])
    }
    
    private func secondTick() {
        guard let timeLeft = timeLeft else { print("Someone forgot to set the timeleft"); return }
        if timeLeft > 0 {
            self.timeLeft = timeLeft - 1
            delegate?.timerSecondTicked()
        } else {
            self.timeLeft = nil
            timer?.invalidate()
            delegate?.timerCompleted()
        }
    }
}
