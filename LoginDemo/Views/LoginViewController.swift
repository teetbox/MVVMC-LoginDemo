//
//  LoginViewController.swift
//  LoginDemo
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Login"
        view.backgroundColor = .white

        setupViews()
        
        hideKeyboardWhenTappedAround()
        
        viewModel.checkHasLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        accountTextField.text = nil
        passwordTextField.text = nil
    }
    
    let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "UserID:"
        label.textAlignment = .right
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password:"
        label.textAlignment = .right
        return label
    }()
    
    let accountTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    private func setupViews() {
        view.addSubview(accountLabel)
        view.addSubview(passwordLabel)
        view.addSubview(accountTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
        
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        view.addConstraints(format: "H:|-20-[v0(100)]-10-[v1]-20-|", views: accountLabel, accountTextField)
        view.addConstraints(format: "H:|-20-[v0(100)]-10-[v1]-20-|", views: passwordLabel, passwordTextField)
        
        view.addConstraints(format: "V:|-180-[v0(30)]-10-[v1(30)]-40-[v2(30)]", views: accountLabel, passwordLabel, registerButton)
        view.addConstraints(format: "V:|-180-[v0(30)]-10-[v1(30)]-40-[v2(30)]", views: accountTextField, passwordTextField, loginButton)
        
        view.addConstraints(format: "H:|-40-[v0(100)]", views: registerButton)
        view.addConstraints(format: "H:[v0(100)]-40-|", views: loginButton)
    }
    
    @objc func registerTapped() {
        viewModel.register()
    }
    
    @objc func loginTapped() {
        viewModel.login(userID: accountTextField.text, password: passwordTextField.text) { errorMessage in
            if errorMessage != nil {
                showValidateError(message: errorMessage!)
            }
        }
    }
    
    private func showValidateError(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true)
    }

}
