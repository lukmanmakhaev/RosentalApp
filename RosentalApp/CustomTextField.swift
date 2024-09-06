//
//  CustomTextField.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 04.09.2024.
//

import Foundation
import UIKit


final class CustomTextField: UIView {
    
    private let icon: UIImage?
    private let placeholderText: String
    private let isPassword: Bool
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.8
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.cornerRadius = 8
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = " E-mail "
        label.backgroundColor = .white
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var togglePasswordVisibilityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private var isUp: Bool = false {
        didSet {
            styleLabel(isUp: isUp)
            moveLabel(isUp: isUp)
        }
    }
    
    init(placeholderText: String, icon: UIImage? = nil, isPassword: Bool = false) {
        self.placeholderText = placeholderText
        self.icon = icon
        self.isPassword = isPassword
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        
        textField.delegate = self
        if let icon = self.icon {
            textField.addPaddingAndIcon(icon, padding: 20, isLeftView: true)
        }
        
        placeholderLabel.text = " \(placeholderText) "
        
        addSubview(textField)
        addSubview(placeholderLabel)
        
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        placeholderLabel.leftAnchor.constraint(equalTo: textField.leftAnchor, constant: 30).isActive = true
        placeholderLabel.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        
        if isPassword {
            textField.isSecureTextEntry = true
            addSubview(togglePasswordVisibilityButton)
            togglePasswordVisibilityButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
            togglePasswordVisibilityButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
            togglePasswordVisibilityButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
            togglePasswordVisibilityButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
        
        styleLabel(isUp: false)
    }
    
    private func styleLabel(isUp: Bool) {
        UIView.transition(
            with: placeholderLabel,
            duration: 0.15,
            options: .curveEaseInOut,
            animations: {
                if isUp {
                    self.placeholderLabel.font = UIFont(name: "Arial", size: 12)
                } else {
                    self.placeholderLabel.font = UIFont(name: "Arial", size: 16)
                }
            },
            completion: nil
        )
    }
    
    private func moveLabel(isUp: Bool) {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                if isUp {
                    let offsetX = self.placeholderLabel.frame.width * 0.3
                    let translation = CGAffineTransform(translationX: -offsetX, y: -self.textField.frame.height / 2)
                    let scale = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.placeholderLabel.transform = translation.concatenating(scale)
                } else {
                    self.placeholderLabel.transform = .identity
                }
            },
            completion: nil
        )
    }
    
    @objc private func togglePasswordVisibility() {
            textField.isSecureTextEntry.toggle()
            togglePasswordVisibilityButton.isSelected = !textField.isSecureTextEntry
        }
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Text field did begin editing")
        if !isUp {
            isUp = true
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("Should end editing")
        guard let text = textField.text else {
            return false
        }
        
        if isUp && text.isEmpty {
            isUp = false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
