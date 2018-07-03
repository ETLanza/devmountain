//
//  FlashlightTests.swift
//  FlashlightTests
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import XCTest
@testable import Flashlight

class FlashlightTests: XCTestCase {
    var appToTest: ViewController!
    
    override func setUp() {
        super.setUp()
        appToTest = UIStoryboard(name: "Main",
                                 bundle: nil).instantiateInitialViewController() as! ViewController?
        appToTest.viewDidLoad()
        appToTest.viewWillAppear(false)
    }
    
    override func tearDown() {
        super.tearDown()
        appToTest = nil
    }
    
    func testIsOn() {
        appToTest.toggleFlashlight()
        let isOnBool = appToTest.isOn
        XCTAssertTrue(isOnBool)
    }
    
    func testBackgroundColor() {
        let backgroundUIColor = appToTest.view.backgroundColor
        XCTAssertFalse(backgroundUIColor == UIColor.white)
        XCTAssert(backgroundUIColor == UIColor.black)
    }
    
    func testButtonText(){
        let button = appToTest.toggleButton
        let buttonTitle = button?.currentTitle
        XCTAssertTrue(buttonTitle == "On")
    }
    
    func testToggleFlashLight() {
        appToTest.toggleFlashlight()
        XCTAssert(appToTest.view.backgroundColor == UIColor.white && appToTest.toggleButton.currentTitle == "Off")
    }
    
    
    
}
