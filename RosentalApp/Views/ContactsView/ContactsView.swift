//
//  ContactView.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 05.09.2024.
//

import Foundation
import UIKit

final class ContactsView: UIViewController {
    
    let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.configuration = .filled()
        button.configuration?.cornerStyle = .medium
        button.tintColor = UIColor(named: "orangeTest")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(logOutButton)
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
    }
    
    @objc private func logOutTapped() {
        AuthService.shared.logout()
    }
}
