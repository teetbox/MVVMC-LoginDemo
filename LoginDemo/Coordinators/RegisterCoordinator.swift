//
//  RegisterCoordinator.swift
//  LoginDemo
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import UIKit

class RegisterCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let registerVC = RegisterViewController()
        var viewModel = RegisterViewModel()
        
        viewModel.coordinatorDelegate = self
        viewModel.defaults = UserDefaults.standard
        registerVC.viewModel = viewModel
        
        let topViewController = UIApplication.topViewController(base: window.rootViewController)
        
        topViewController?.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}

extension RegisterCoordinator: RegisterViewModelCoordinatorDelegate {
    
    func toUser() {
        let topViewController = UIApplication.topViewController(base: window.rootViewController)
        topViewController?.navigationController?.popToRootViewController(animated: false)
        
        let userCoordinator = UserCoordinator(window: window)
        userCoordinator.start()
    }
    
}
