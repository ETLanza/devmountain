//
//  SolarSystemUITests.swift
//  SolarSystemUITests
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import XCTest

class SolarSystemUITests: XCTestCase {
        let cells = XCUIApplication().cells

    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        XCTAssert(cells.count == 9)
    }
    
}
