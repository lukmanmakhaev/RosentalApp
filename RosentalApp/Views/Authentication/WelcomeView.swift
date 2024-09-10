//
//  WelcomeView.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 03.09.2024.
//

import Foundation
import UIKit

final class WelcomeView: UIViewController {
    
    var authService = AuthService.shared
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать!"
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизуйтесь, чтобы продолжить работу"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Вход", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.configuration = .filled()
        button.configuration?.cornerStyle = .medium
        button.tintColor = UIColor(named: "orangeTest")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.configuration = .plain()
        button.configuration?.cornerStyle = .medium
        button.configuration?.background.strokeWidth = 1
        button.configuration?.background.strokeColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let inviteIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "house")
        icon.tintColor = .systemBlue
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let inviteLabel: UILabel = {
        let label = UILabel()
        label.text = "Пригласить управлять своим домом"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var inviteStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [inviteIcon, inviteLabel])
        stack.axis = .horizontal
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupLayout() {
        view.addSubview(logoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(instructionLabel)
        view.addSubview(loginButton)
        view.addSubview(registrationButton)
        view.addSubview(inviteStack)

        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        let bottomPadding: CGFloat = 40.0
        
        inviteStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -bottomPadding).isActive = true
        inviteStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        registrationButton.bottomAnchor.constraint(equalTo: inviteLabel.topAnchor, constant: -20).isActive = true
        registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        registrationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginButton.bottomAnchor.constraint(equalTo: registrationButton.topAnchor, constant: -20).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        instructionLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -25).isActive = true
        instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        welcomeLabel.bottomAnchor.constraint(equalTo: instructionLabel.topAnchor, constant: -30).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func didTapLoginButton() {
        let signInVC = SignInView()
        navigationController?.pushViewController(signInVC, animated: true)
    }
}
