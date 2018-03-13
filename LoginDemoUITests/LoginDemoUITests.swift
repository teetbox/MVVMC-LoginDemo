//
//  LoginDemoUITests.swift
//  LoginDemoUITests
//
//  Created by Matt Tian on 13/03/2018.
//  Copyright © 2018 TTSY. All rights reserved.
//

import XCTest

class LoginDemoUITests: XCTestCase {
    
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    func testLoginViewDisplayed() {
        XCTAssert(app.isLoginDisplying)
    }
    
    func testRegisterViewDisplayed() {
        app.buttons["Register"].tap()
        
        XCTAssert(app.isRegisterDisplaying)
    }
    
}
