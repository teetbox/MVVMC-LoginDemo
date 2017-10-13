//
//  RegisterViewModelTests.swift
//  LoginDemoTests
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import XCTest
@testable import LoginDemo

class RegisterViewModelTests: XCTestCase {
    
    var viewModel: RegisterViewModel!
    
    var username: String?
    var email: String?
    var phone: String?
    var userID: String?
    var password: String?
    var password2: String?
    
    override func setUp() {
        super.setUp()
        
        viewModel = RegisterViewModel()
        
        username = "Matt Tian"
        email = "matt@gmail.com"
        phone = "62776977"
        userID = "matt"
        password = "mattmatt"
        password2 = "mattmatt"
    }
    
    func testValidate() {
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            XCTFail()
        }
        
    }
    
    func testValidateErrorWithNameEmpty() {
        username = nil
        
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            let validateError = error as! ValidateError
            XCTAssertEqual(validateError, ValidateError.empty(.name))
        }
        
        username = ""
        
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            let validateError = error as! ValidateError
            XCTAssertEqual(validateError, ValidateError.empty(.name))
        }
    }
    
    func testValidateErrorWithEmailEmpty() {
        email = nil
        
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            let validateError = error as! ValidateError
            XCTAssertEqual(validateError, ValidateError.empty(.email))
        }
        
        email = ""
        
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            let validateError = error as! ValidateError
            XCTAssertEqual(validateError, ValidateError.empty(.email))
        }
    }
    
    func testValidateErrorWithEmailInvalid() {
        email = "email.com"
        
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            let validateError = error as! ValidateError
            XCTAssertEqual(validateError, ValidateError.invalid("invalid email address"))
        }
    }
    
    func testValidateErrorWithPhoneEmpty() {
        phone = nil
        
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            let validateError = error as! ValidateError
            XCTAssertEqual(validateError, ValidateError.empty(.phone))
        }
        
        phone = ""
        
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            let validateError = error as! ValidateError
            XCTAssertEqual(validateError, ValidateError.empty(.phone))
        }
    }
    
    func testValidateErrorWithUserIDEmpty() {
        userID = nil
        
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            let validateError = error as! ValidateError
            XCTAssertEqual(validateError, ValidateError.empty(.userID))
        }
        
        userID = ""
        
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            let validateError = error as! ValidateError
            XCTAssertEqual(validateError, ValidateError.empty(.userID))
        }
    }
    
    func testValidateErrorWithPasswordEmpty() {
        password = nil
        
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            let validateError = error as! ValidateError
            XCTAssertEqual(validateError, ValidateError.empty(.password))
        }
        
        password = ""
        
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            let validateError = error as! ValidateError
            XCTAssertEqual(validateError, ValidateError.empty(.password))
        }
    }
    
    func testValidateErrorWithPassword2Empty() {
        password2 = nil
        
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            let validateError = error as! ValidateError
            XCTAssertEqual(validateError, ValidateError.empty(.password))
        }
        
        password2 = ""
        
        do {
            try viewModel.validate(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            let validateError = error as! ValidateError
            XCTAssertEqual(validateError, ValidateError.empty(.password))
        }
    }
    
    func testConfirm() {
        let delegate = MockRegisterViewModelCoordinatorDelegate()
        viewModel.coordinatorDelegate = delegate
        
        viewModel.confirm(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2) { errorMessage in
            XCTAssertNil(errorMessage)
        }
        
        XCTAssertEqual(delegate.isToUserCall, true)
    }
    
    func testConfirmWithMismatchPasswords() {
        password = "WeAreSame"
        password2 = "WeAreNotSame"
        
        viewModel.confirm(name: username, email: email, phone: phone, userID: userID, password: password, password2: password2) { errorMessage in
            XCTAssertEqual(errorMessage, "two passwords are not same")
        }
    }
    
    func testSaveUser() {
        let mockDefaults = MockDefaults()
        viewModel.defaults = mockDefaults
        
        let user = User(name: username!, email: email!, phone: phone!, userID: userID!, password: password!)
        
        viewModel.saveUser(user: user)
        let encodedUser = try? PropertyListEncoder().encode(user)
        XCTAssertEqual(mockDefaults[user.userID] as? Data, encodedUser)
        XCTAssertEqual(mockDefaults["hasLogin"] as! String, user.userID)
    }
    
}

class MockRegisterViewModelCoordinatorDelegate: RegisterViewModelCoordinatorDelegate {
    
    var isToUserCall = false
    
    func toUser() {
        isToUserCall = true
    }
}

class MockDefaults: DefaultsProtocol {
    
    var stub = Dictionary<String, Any>()
    
    subscript(key: String) -> Any? {
        get {
            return stub[key]
        } set {
            stub[key] = newValue
        }
    }
    
}

extension ValidateError: Hashable {
    
    public var hashValue: Int {
        switch self {
        case .empty(let field):
            return "empty \(field.rawValue)".hashValue
        case .invalid(let message):
            return "invalid \(message)".hashValue
        case .mismatch:
            return "mismatch".hashValue
        }
    }
    
}

extension ValidateError: Equatable {
    
    public static func ==(lhs: ValidateError, rhs: ValidateError) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}

extension User: Equatable {
    
    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name
            && lhs.email == rhs.email
            && lhs.phone == rhs.phone
            && lhs.userID == rhs.userID
            && lhs.password == rhs.password
    }
    
}
