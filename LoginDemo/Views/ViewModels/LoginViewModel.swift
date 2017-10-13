//
//  LoginViewModel.swift
//  LoginDemo
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import Foundation

protocol LoginViewModelCoordinatorDelegate {
    func toRegister()
    func toUser()
}

struct LoginViewModel {
    
    var coordinatorDelegate: LoginViewModelCoordinatorDelegate?
    var defaults: DefaultsProtocol?
    
    var user: User?
    var isLogin = false
    
    func checkHasLogin() {
        guard let _ = defaults?["hasLogin"] as? String else { return }
        
        coordinatorDelegate?.toUser()
    }
    
    mutating func login(userID: String?, password: String?, completion: (_ errorMessage: String?) -> Void) {
        
        guard validateNilAndEmpty(str: userID) else {
            completion(ValidateError.empty(.userID).localizedDescription)
            return
        }
        
        guard validateNilAndEmpty(str: password) else {
            completion(ValidateError.empty(.password).localizedDescription)
            return
        }
        
        guard let encodedUser = defaults?[userID!] as? Data else {
            completion(ValidateError.invalid("not found this userID").localizedDescription)
            return
        }
        
        user = try? PropertyListDecoder().decode(User.self, from: encodedUser)
        
        if user?.password == password {
            defaults?["hasLogin"] = user?.userID
            coordinatorDelegate?.toUser()
        } else {
            completion(ValidateError.invalid("password is not correct").localizedDescription)
        }
    }
    
    private func validateNilAndEmpty(str: String?) -> Bool {
        return (str != nil && str != "") ? true : false
    }
    
    func register() {
        coordinatorDelegate?.toRegister()
    }
    
}
