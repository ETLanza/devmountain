//
//  JournalTests.swift
//  JournalTests
//
//  Created by Eric Lanza on 7/4/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import XCTest
@testable import Journal

class JournalTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDecoder() {
        let path = NSTemporaryDirectory() as NSString
        let locToSave = path.appendingPathComponent("testentry")
        
        let newEntry = Entry(title: "Test", bodyText: "This is a test", timestamp: Date())
        
        NSKeyedArchiver.archiveRootObject([newEntry], toFile: locToSave)
        
        let data = NSKeyedUnarchiver.unarchiveObject(withFile: locToSave) as? [Entry]
        
        XCTAssertNotNil(data)
        XCTAssertEqual(data!.count, 1)
        XCTAssertEqual(data!.first?.title, "Test")
        XCTAssertEqual(data!.first?.bodyText, "This is a test")
//        XCTAssertEqual(data!.first?.timestamp, "4:01")
    }
    
    func testEncoder() {
//        let path = NSTemporaryDirectory() as NSString
//        let locToSave = path.appendingPathComponent("testentry")
        let coder = NSKeyedArchiver()
        let newEntry = Entry(title: "Test", bodyText: "This is a test", timestamp: Date())
        try? newEntry.encode(to: coder as! Encoder)
        let dataToTest = coder.decodeData()
        XCTAssertNil(dataToTest)
        print(dataToTest as Any)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
