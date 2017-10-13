//
//  UserViewModelTests.swift
//  LoginDemoTests
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import XCTest
@testable import LoginDemo

class UserViewModelTests: XCTestCase {
    
    var viewModel: UserViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = UserViewModel()
    }
    
    func testLoadData() {
        let mockDefaults = MockDefaults()
        viewModel.defaults = mockDefaults
        
        let user = User(name: "Matt", email: "matt@gmail.com", phone: "62776977", userID: "matt", password: "mattmatt")
        mockDefaults.stub["hasLogin"] = user.userID
        mockDefaults.stub[user.userID] = try? PropertyListEncoder().encode(user)
        
        viewModel.loadData {}
        
        XCTAssertEqual(viewModel.name, "Welcome Matt")
        XCTAssertEqual(viewModel.email, "Email: matt@gmail.com")
        XCTAssertEqual(viewModel.phone, "Phone: 62776977")
    }
    
    func testLogout() {
        let mockDefaults = MockDefaults()
        mockDefaults.stub["hasLogin"] = "matt"
        viewModel.defaults = mockDefaults
        
        let delegate = MockUserViewModelCoordinatorDelegate()
        viewModel.coordinatorDelegate = delegate
        
        viewModel.logout()
        
        XCTAssertEqual(mockDefaults.stub["hasLogin"] as? String, nil)
        XCTAssertEqual(delegate.isToLoginCalled, true)
    }
    
}

class MockUserViewModelCoordinatorDelegate: UserViewModelCoordinatorDelegate {
    
    var isToLoginCalled = false
    
    func toLogin() {
        isToLoginCalled = true
    }
    
}
