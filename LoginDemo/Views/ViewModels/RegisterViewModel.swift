//
//  RegisterViewModel.swift
//  LoginDemo
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import Foundation

protocol RegisterViewModelCoordinatorDelegate {
    func toUser()
}

enum ValidateError: Error {
    case empty(EmptyField)
    case invalid(String)
    case mismatch
    
    enum EmptyField: String {
        case name
        case email
        case phone
        case userID
        case password
    }
}

extension ValidateError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .empty(let field):
            return field.localizedDescription
        case .invalid(let message):
            return message
        case .mismatch:
            return "two passwords are not same"
        }
    }
}

extension ValidateError.EmptyField {
    var localizedDescription: String {
        return "\(rawValue) is empty"
    }
}

struct RegisterViewModel {
    
    var coordinatorDelegate: RegisterViewModelCoordinatorDelegate?
    var defaults: DefaultsProtocol?
    
    func validate(name: String?, email: String?, phone: String?, userID: String?, password: String?, password2: String?) throws {
        
        guard validateNilAndEmpty(str: name) else { throw ValidateError.empty(.name) }
        guard validateNilAndEmpty(str: email) else { throw ValidateError.empty(.email) }
        guard validateNilAndEmpty(str: phone) else { throw ValidateError.empty(.phone) }
        guard validateNilAndEmpty(str: userID) else { throw ValidateError.empty(.userID) }
        guard validateNilAndEmpty(str: password) else { throw ValidateError.empty(.password) }
        guard validateNilAndEmpty(str: password2) else { throw ValidateError.empty(.password) }
        
        guard email!.contains("@") else { throw ValidateError.invalid("invalid email address") }
        guard password == password2 else { throw ValidateError.mismatch }
    }
    
    private func validateNilAndEmpty(str: String?) -> Bool {
        return (str != nil && str != "") ? true : false
    }
    
    mutating func confirm(name: String?, email: String?, phone: String?, userID: String?, password: String?, password2: String?, completion: (_ errorMessage: String?) -> Void) {
        do {
            try validate(name: name, email: email, phone: phone, userID: userID, password: password, password2: password2)
        } catch {
            completion((error as! ValidateError).localizedDescription)
            return
        }
        
        completion(nil)
        
        let user = User(name: name!, email: email!, phone: phone!, userID: userID!, password: password!)
        
        saveUser(user: user)
        
        coordinatorDelegate?.toUser()
    }
    
    mutating func saveUser(user: User) {
        let encodedUser = try? PropertyListEncoder().encode(user)
        
        defaults?[user.userID] = encodedUser
        defaults?["hasLogin"] = user.userID
    }
    
}
