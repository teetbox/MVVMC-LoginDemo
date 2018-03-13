//
//  XCUIApplication+Displaying.swift
//  LoginDemoUITests
//
//  Created by Matt Tian on 13/03/2018.
//  Copyright © 2018 TTSY. All rights reserved.
//

import XCTest

extension XCUIApplication {
    
    var isLoginDisplying: Bool {
        return otherElements["LoginView"].exists
    }
    
    var isRegisterDisplaying: Bool {
        return otherElements["Register"].exists
    }
    
}
