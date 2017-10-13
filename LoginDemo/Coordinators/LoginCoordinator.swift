//
//  LoginCoordinator.swift
//  LoginDemo
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let loginVC = LoginViewController()
        var viewModel = LoginViewModel()
        
        viewModel.coordinatorDelegate = self
        viewModel.defaults = UserDefaults.standard
        loginVC.viewModel = viewModel
        
        window.rootViewController = UINavigationController(rootViewController: loginVC)
    }
    
}

extension LoginCoordinator: LoginViewModelCoordinatorDelegate {
    
    func toRegister() {
        let registerCoordinator = RegisterCoordinator(window: window)
        registerCoordinator.start()
    }
    
    func toUser() {
        let userCoordinator = UserCoordinator(window: window)
        userCoordinator.start()
    }
    
}
