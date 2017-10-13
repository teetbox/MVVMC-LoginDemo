//
//  UserViewModel.swift
//  LoginDemo
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import Foundation

protocol UserViewModelCoordinatorDelegate {
    func toLogin()
}

struct UserViewModel {
    
    var coordinatorDelegate: UserViewModelCoordinatorDelegate?
    var defaults: DefaultsProtocol?
    
    var user: User?
    var name: String?
    var email: String?
    var phone: String?
    
    mutating func loadData(completion: @escaping () -> Void) {
        guard let userID = defaults?["hasLogin"] as? String else { return }
        guard let encodedUser = defaults?[userID] as? Data else { return }
        
        user = try? PropertyListDecoder().decode(User.self, from: encodedUser)
        
        guard user != nil else { return }
        name = "Welcome \(user!.name)"
        email = "Email: \(user!.email)"
        phone = "Phone: \(user!.phone)"
        
        DispatchQueue.main.async {
            completion()
        }
    }
    
    mutating func logout() {
        defaults?["hasLogin"] = nil
        coordinatorDelegate?.toLogin()
    }
    
}
