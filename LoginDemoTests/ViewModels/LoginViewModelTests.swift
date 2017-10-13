//
//  LoginViewModelTests.swift
//  LoginDemoTests
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import XCTest
@testable import LoginDemo

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = LoginViewModel()
    }
    
    func testIsLogin() {
        XCTAssertEqual(viewModel.isLogin, false)
    }
    
    func testLogin() {
        let mockDefaults = MockDefaults()
        let user = User(name: "Matt", email: "matt@gmail.com", phone: "62776977", userID: "matt", password: "mattmatt")
        
        mockDefaults.stub[user.userID] = try? PropertyListEncoder().encode(user)
        viewModel.defaults = mockDefaults
        
        let delegate = MockLoginViewModelCoordinatorDelegate()
        viewModel.coordinatorDelegate = delegate
        
        viewModel.login(userID: "matt", password: "mattmatt", completion: {_ in })
        
        XCTAssertEqual(delegate.isToUserCalled, true)
    }
    
    func testLoginWithEmptyUserID() {
        let delegate = MockLoginViewModelCoordinatorDelegate()
        viewModel.coordinatorDelegate = delegate
        
        viewModel.login(userID: "", password: "mattmatt") { errorMessage in
            XCTAssertEqual(errorMessage, "userID is empty")
        }
        
        XCTAssertEqual(delegate.isToUserCalled, false)
    }
    
    func testLoginWithEmptyPassword() {
        let delegate = MockLoginViewModelCoordinatorDelegate()
        viewModel.coordinatorDelegate = delegate
        
        viewModel.login(userID: "matt", password: "") { errorMessage in
            XCTAssertEqual(errorMessage, "password is empty")
        }
        
        XCTAssertEqual(delegate.isToUserCalled, false)
    }
    
    func testLoginWithInvalidUserID() {
        let mockDefaults = MockDefaults()
        let user = User(name: "Matt", email: "matt@gmail.com", phone: "62776977", userID: "matt", password: "mattmatt")
        
        mockDefaults.stub[user.userID] = try? PropertyListEncoder().encode(user)
        viewModel.defaults = mockDefaults
        
        let delegate = MockLoginViewModelCoordinatorDelegate()
        viewModel.coordinatorDelegate = delegate
        
        viewModel.login(userID: "matt2", password: "mattmatt") { errorMessage in
            XCTAssertEqual(errorMessage, "not found this userID")
        }
        
        XCTAssertEqual(delegate.isToUserCalled, false)
    }
    
    func testLoginWithInvalidPassword() {
        let mockDefaults = MockDefaults()
        let user = User(name: "Matt", email: "matt@gmail.com", phone: "62776977", userID: "matt", password: "mattmatt")
        
        mockDefaults.stub[user.userID] = try? PropertyListEncoder().encode(user)
        viewModel.defaults = mockDefaults
        
        let delegate = MockLoginViewModelCoordinatorDelegate()
        viewModel.coordinatorDelegate = delegate
        
        viewModel.login(userID: "matt", password: "matt") { errorMessage in
            XCTAssertEqual(errorMessage, "password is not correct")
        }
        
        XCTAssertEqual(delegate.isToUserCalled, false)
    }
    
    func testRegisterTapped() {
        let delegate = MockLoginViewModelCoordinatorDelegate()
        
        viewModel.coordinatorDelegate = delegate
        viewModel.register()
        
        XCTAssertEqual(delegate.isToRegisterCalled, true)
    }
    
    func testCheckHasLogin() {
        let mockDefaults = MockDefaults()
        let user = User(name: "Matt", email: "matt@gmail.com", phone: "62776977", userID: "matt", password: "mattmatt")
        
        mockDefaults.stub["hasLogin"] = user.userID
        mockDefaults.stub[user.userID] = try? PropertyListEncoder().encode(user)
        viewModel.defaults = mockDefaults
        
        let delegate = MockLoginViewModelCoordinatorDelegate()
        viewModel.coordinatorDelegate = delegate
        
        viewModel.checkHasLogin()
        
        XCTAssertEqual(delegate.isToUserCalled, true)
    }
    
}

class MockLoginViewModelCoordinatorDelegate: LoginViewModelCoordinatorDelegate {
    
    var isToRegisterCalled = false
    var isToUserCalled = false
    
    func toRegister() {
        isToRegisterCalled = true
    }
    
    func toUser() {
        isToUserCalled = true
    }
    
}
