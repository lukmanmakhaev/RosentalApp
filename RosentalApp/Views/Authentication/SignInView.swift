//
//  ViewController.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 03.09.2024.
//

import UIKit

final class SignInView: UIViewController {

    var authService = AuthService.shared
    
    var emailField = CustomTextField(placeholderText: "Email", icon: UIImage(systemName: "at"))
    var passwordField = CustomTextField(placeholderText: "Password", icon: UIImage(systemName: "lock"), isPassword: true)
    
    let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход в аккаунт"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.configuration = .filled()
        button.configuration?.cornerStyle = .medium
        button.tintColor = UIColor(named: "orangeTest")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavigationBar()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(signInLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        signInLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        signInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        signInLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        signInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 20).isActive = true
        emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        setupBackButton()
        setupForgotPasswordButton()
    }
    
    private func setupBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        backButton.tintColor = .gray
        backButton.backgroundColor = .systemGray6
        backButton.layer.cornerRadius = 15
        backButton.clipsToBounds = true
        
        let leftNavBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    private func setupForgotPasswordButton() {
        let forgotPasswordButton = UIButton(type: .system)
        forgotPasswordButton.setTitle("Забыли пароль?", for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        forgotPasswordButton.tintColor = .gray
        
        let rightNavBarButton = UIBarButtonItem(customView: forgotPasswordButton)
        navigationItem.rightBarButtonItem = rightNavBarButton
    }
    
    @objc private func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func forgotPasswordTapped() {
        print("Forgot Password tapped")
    }
    
    
    @objc private func loginTapped() {
        guard let email = emailField.textField.text, !email.isEmpty else {
            print("Email field is empty")
            return
        }
        guard let password = passwordField.textField.text, !password.isEmpty else {
            print("Password field is empty")
            return
        }
        authService.login(email: email, password: password)
    }
}
