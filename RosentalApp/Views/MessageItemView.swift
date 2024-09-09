//
//  MessageItemView.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 08.09.2024.
//

import Foundation
import UIKit

class MessageItemView: UIView {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let messageCount: Int = 3

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let redDotView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 5 // Half of the width/height to make it circular
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {

        addSubview(containerView)

        containerView.addSubview(messageLabel)
        containerView.addSubview(redDotView)

    }

    private func setupConstraints() {

        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        setupMessageLabel()
        messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        newMessage()
    }
    
    func setupMessageLabel() {
        switch messageCount {
        case 0:
            return messageLabel.text = "Новых cообщений нет"
        case 1:
            return messageLabel.text = "\(messageCount) сообщение от УК"
        case 2...4:
            return messageLabel.text = "\(messageCount) сообщения от УК"
        default:
            return messageLabel.text = "\(messageCount) сообщений от УК"
        }
    }
    
    func newMessage() {
        if messageCount > 0 {
            redDotView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
            redDotView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            redDotView.widthAnchor.constraint(equalToConstant: 10).isActive = true
            redDotView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        }
    }
}

#Preview {
    MessageItemView()
}
