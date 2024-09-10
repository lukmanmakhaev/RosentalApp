//
//  MenuItemView.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 08.09.2024.
//

import Foundation
import UIKit

class MenuItemView: UIView {
    
    let item: MenuItem
    
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
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconGroupStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let waterIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "drop.fill"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let electricityIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "bolt.fill"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let temperatureIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "thermometer"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gasIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "flame.fill"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    init(menuItem: MenuItem) {
        self.item = menuItem
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setValues()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setValues() {
        titleLabel.text = item.name
        subtitleLabel.text = item.description
        priceLabel.text = item.arrear
    }
    
    private func setupViews() {
        addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        iconGroupStackView.addArrangedSubview(waterIcon)
        iconGroupStackView.addArrangedSubview(electricityIcon)
        iconGroupStackView.addArrangedSubview(temperatureIcon)
        iconGroupStackView.addArrangedSubview(gasIcon)
        
    }
    
    private func setupConstraints() {
        
        iconContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        iconContainerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconContainerView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        iconContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20).isActive = true
        
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        checkAction()
    }
    
    func checkAction() {
        switch item.action {
        case "payment":
            iconImageView.image = UIImage(systemName: "clock.arrow.2.circlepath")
            return setupPriceLabel()
        default:
            iconImageView.image = UIImage(systemName: "lines.measurement.horizontal")
            return setupIconsGroup()
        }
    }
    
    func setupPriceLabel() {
        addSubview(priceLabel)
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 12).isActive = true
    }
    
    func setupIconsGroup() {
        addSubview(iconGroupStackView)
        iconGroupStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        iconGroupStackView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        iconGroupStackView.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    
}

#Preview {
    MenuItemView(menuItem: MenuItem(action: "payment", name: "Квартплата", description: "Оплатить до 253", arrear: "0.00", amountCoins: 0, expected: nil))
}

