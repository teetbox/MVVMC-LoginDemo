//
//  UserCoordinator.swift
//  LoginDemo
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import UIKit

class UserCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let userVC = UserViewController()
        var viewModel = UserViewModel()
        
        viewModel.coordinatorDelegate = self
        viewModel.defaults = UserDefaults.standard
        userVC.viewModel = viewModel
        
        let topViewController = UIApplication.topViewController(base: window.rootViewController)
        
        let userNav = UINavigationController(rootViewController: userVC)
        topViewController?.navigationController?.present(userNav, animated: true)
    }
    
}

extension UserCoordinator: UserViewModelCoordinatorDelegate {
    
    func toLogin() {
        let topViewController = UIApplication.topViewController(base: window.rootViewController)
        topViewController?.dismiss(animated: true)
    }
    
}
