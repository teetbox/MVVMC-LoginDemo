//
//  RegisterViewController.swift
//  LoginDemo
//
//  Created by Tong Tian on 10/12/17.
//  Copyright © 2017 TTSY. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var viewModel: RegisterViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Register"
        view.backgroundColor = .white
        
        setupViews()
        
        hideKeyboardWhenTappedAround()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.textAlignment = .right
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.textAlignment = .right
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone:"
        label.textAlignment = .right
        return label
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let userIDLabel: UILabel = {
        let label = UILabel()
        label.text = "UserID:"
        label.textAlignment = .right
        return label
    }()
    
    let userIDTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password:"
        label.textAlignment = .right
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passwordTextField2: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password again"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    private func setupViews() {
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextField)
        view.addSubview(userIDLabel)
        view.addSubview(userIDTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordTextField2)
        view.addSubview(confirmButton)
        
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        
        view.addConstraints(format: "H:|-20-[v0(80)]-10-[v1]-20-|", views: nameLabel, nameTextField)
        view.addConstraints(format: "H:|-20-[v0(80)]-10-[v1]-20-|", views: emailLabel, emailTextField)
        view.addConstraints(format: "H:|-20-[v0(80)]-10-[v1]-20-|", views: phoneLabel, phoneTextField)
        view.addConstraints(format: "H:|-20-[v0(80)]-10-[v1]-20-|", views: userIDLabel, userIDTextField)
        view.addConstraints(format: "H:|-20-[v0(80)]-10-[v1]-20-|", views: passwordLabel, passwordTextField)
        view.addConstraints(format: "H:|-110-[v0]-20-|", views: passwordTextField2)
        view.addConstraints(format: "H:[v0(100)]", views: confirmButton)
        
        view.addConstraints(format: "V:|-84-[v0(30)]-10-[v1(30)]-10-[v2(30)]-10-[v3(30)]-10-[v4(30)]-80-[v5(30)]", views: nameLabel, emailLabel, phoneLabel, userIDLabel, passwordLabel, confirmButton)
        view.addConstraints(format: "V:|-84-[v0(30)]-10-[v1(30)]-10-[v2(30)]-10-[v3(30)]-10-[v4(30)]-10-[v5(30)]", views: nameTextField, emailTextField, phoneTextField, userIDTextField, passwordTextField, passwordTextField2)
        
        confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func confirmTapped() {
        viewModel.confirm(name: nameTextField.text, email: emailTextField.text, phone: phoneTextField.text, userID: userIDTextField.text, password: passwordTextField.text, password2: passwordTextField2.text) { errorMessage in
            if (errorMessage != nil) {
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
