//
//  MainViewController.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 05.09.2024.
//

import Foundation
import UIKit
import Combine

final class MainView: UIViewController {
    var mainViewModel = MainViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profilePlaceholder")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 19
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let notificationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageItemView = MessageItemView()
    
    private let menuItemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bannerScrollview: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var bannerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let serviceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let allServicesBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Все сервисы", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.configuration = .filled()
        button.configuration?.cornerStyle = .medium
        button.tintColor = UIColor(named: "orangeTest")
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        mainViewModel.$dashboard
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedDashboard in
                self?.updateUI()
            }
            .store(in: &cancellables)
        mainViewModel.getDashboard()
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(addressLabel)
        view.addSubview(notificationButton)
        
        view.addSubview(contentView)
        
        contentView.addSubview(todayLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(messageItemView)
        contentView.addSubview(menuItemsStackView)
        
        contentView.addSubview(bannerScrollview)
        bannerScrollview.addSubview(bannerStackView)
        
        contentView.addSubview(serviceStackView)
        
        contentView.addSubview(allServicesBtn)
        
    }
    
    func setupConstraints() {
        profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 38).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        notificationButton.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        notificationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        notificationButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        notificationButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: notificationButton.leadingAnchor, constant: -20).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 30).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        todayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        todayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: todayLabel.trailingAnchor).isActive = true
        
        messageItemView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
        messageItemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        messageItemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        messageItemView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        messageItemView.translatesAutoresizingMaskIntoConstraints = false
        
        menuItemsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        menuItemsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        menuItemsStackView.topAnchor.constraint(equalTo: messageItemView.bottomAnchor, constant: 20).isActive = true
        
        bannerScrollview.topAnchor.constraint(equalTo: menuItemsStackView.bottomAnchor, constant: 10).isActive = true
        bannerScrollview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        bannerScrollview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        bannerScrollview.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        bannerStackView.topAnchor.constraint(equalTo: bannerScrollview.topAnchor).isActive = true
        bannerStackView.leadingAnchor.constraint(equalTo: bannerScrollview.leadingAnchor, constant: 20).isActive = true
        bannerStackView.trailingAnchor.constraint(equalTo: bannerScrollview.trailingAnchor).isActive = true
        bannerStackView.bottomAnchor.constraint(equalTo: bannerScrollview.bottomAnchor).isActive = true
        bannerStackView.heightAnchor.constraint(equalTo: bannerScrollview.heightAnchor).isActive = true
        
        serviceStackView.topAnchor.constraint(equalTo: bannerStackView.bottomAnchor, constant: 20).isActive = true
        serviceStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20).isActive = true
        serviceStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        allServicesBtn.translatesAutoresizingMaskIntoConstraints = false
        allServicesBtn.topAnchor.constraint(equalTo: serviceStackView.bottomAnchor, constant: 20).isActive = true
        allServicesBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        allServicesBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        allServicesBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        allServicesBtn.addTarget(self, action: #selector(allServicesTapped), for: .touchUpInside)

    }
    
    private func updateUI() {
        nameLabel.text = mainViewModel.dashboard?.myProfile.name
        addressLabel.text = mainViewModel.dashboard?.myProfile.address
        
        dateLabel.text = " \(mainViewModel.dashboard?.customerDashboard.date ?? "")"
        messageItemView.messageCount = mainViewModel.dashboard?.myNewNotifications ?? 0
        
        if let photoUrlString = mainViewModel.dashboard?.myProfile.photo {
            mainViewModel.loadImage(from: photoUrlString) { [weak self] image in
                DispatchQueue.main.async {
                    self?.profileImageView.image = image ?? UIImage(named: "profilePlaceholder")
                }
            }
        }
        
        if let menuItems = mainViewModel.dashboard?.customerDashboard.menuItems {
            addMenuItems(menuItems)
        }
        
        if let banners = mainViewModel.dashboard?.customerDashboard.banners {
            addBanners(banners)
        }
        
        if let services = mainViewModel.dashboard?.customerDashboard.services {
            addSerices(services)
        }
    }
    
    @objc private func allServicesTapped() {

    }
    
    private func addMenuItems(_ items: [MenuItem]) {
        menuItemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for menuItem in items {
            let menuItemView = MenuItemView(menuItem: menuItem)
            menuItemsStackView.addArrangedSubview(menuItemView)
        }
    }
    
    private func addBanners(_ banners: [Banner]) {
        bannerStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for banner in banners {
            
            let containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            if let photoUrlString = banner.image {
                mainViewModel.loadImage(from: photoUrlString) { image in
                    DispatchQueue.main.async {
                        let bannerView = BannerItemView(banner: banner)
                        bannerView.imageView.image = image
                        containerView.addSubview(bannerView)
                        bannerView.translatesAutoresizingMaskIntoConstraints = false
                        bannerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
                        bannerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
                        bannerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
                    }
                }
            }
            bannerStackView.addArrangedSubview(containerView)
        }
    }
    
    private func addSerices(_ items: [Service]) {
        serviceStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for serviceItem in items.prefix(3)  {
            let serviceItemView = ServiceItem(service: serviceItem)
            serviceItemView.translatesAutoresizingMaskIntoConstraints = false
            
            serviceItemView.backgroundColor = .systemGray6
            serviceItemView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            serviceItemView.layer.cornerRadius = 10
            serviceStackView.addArrangedSubview(serviceItemView)
        }
    }
}

#Preview {
    MainView()
}

