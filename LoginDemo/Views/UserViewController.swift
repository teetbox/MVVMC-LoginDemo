//
//  UserViewController.swift
//  LoginDemo
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    var viewModel: UserViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "User"
        view.backgroundColor = .white
        
        setupViews()
        
        viewModel.loadData {
            self.nameLabel.text = self.viewModel.name
            self.emailLabel.text = self.viewModel.email
            self.phoneLabel.text = self.viewModel.phone
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    private func setupViews() {
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(phoneLabel)
        view.addSubview(logoutButton)
        
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        
        view.addConstraints(format: "H:[v0]", views: nameLabel)
        view.addConstraints(format: "H:[v0]", views: emailLabel)
        view.addConstraints(format: "H:[v0]", views: phoneLabel)
        view.addConstraints(format: "H:[v0(100)]", views: logoutButton)
        view.addConstraints(format: "V:|-100-[v0(30)]-20-[v1(30)]-20-[v2(30)]-40-[v3(30)]", views: nameLabel, emailLabel, phoneLabel, logoutButton)
        
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        phoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func logoutTapped() {
        viewModel.logout()
    }

}
