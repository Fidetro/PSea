//
//  PSeaTests.swift
//  PSeaTests
//
//  Created by Fidetro on 2018/10/18.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import XCTest
import Alamofire

class PSeaTests: XCTestCase {

    override func setUp() {
        TestRequest().request()
        TestRequest().request()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
