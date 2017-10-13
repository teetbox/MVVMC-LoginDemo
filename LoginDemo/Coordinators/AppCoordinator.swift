//
//  AppCoordinator.swift
//  LoginDemo
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let loginCoordinator = LoginCoordinator(window: window)
        loginCoordinator.start()
    }
    
}
