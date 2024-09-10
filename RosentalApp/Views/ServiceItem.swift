//
//  ServiceItem.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 09.09.2024.
//

import Foundation
import UIKit

class ServiceItem: UIView {
    
    let item: Service
    
    private let iconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let itemTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setValues() {
        itemTitle.text = item.name
        iconImageView.image = UIImage(systemName: item.icon)
    }
    
    init(service: Service) {
        self.item = service
        super.init(frame: .zero)
        setValues()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        
        iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor).isActive = true

        addSubview(itemTitle)

        iconContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        iconContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconContainerView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        iconContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        itemTitle.topAnchor.constraint(equalTo: iconContainerView.bottomAnchor, constant: 4).isActive = true
        itemTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        itemTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

    }
}
