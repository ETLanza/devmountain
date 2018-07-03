//
//  SolarSystemTests.swift
//  SolarSystemTests
//
//  Created by Eric Lanza on 7/3/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import XCTest
@testable import SolarSystem

class SolarSystemTests: XCTestCase {
    
    var appToTest: DetailViewController!
    
    
    override func setUp() {
        super.setUp()
        appToTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        appToTest.viewDidLoad()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let planet = PlanetController.planets
        XCTAssertFalse(planet.isEmpty)
    }
}
