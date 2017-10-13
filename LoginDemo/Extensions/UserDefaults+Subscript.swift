//
//  UserDefaults+Subscript.swift
//  LoginDemo
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import Foundation

protocol DefaultsProtocol {
    subscript(key: String) -> Any? { get set }
}

extension UserDefaults: DefaultsProtocol {
    
    subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        } set {
            set(newValue, forKey: key)
        }
    }
    
}
