//
//  MainTabBarController.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 05.09.2024.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {
    
    var authService = AuthService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabBarAppearance()
    }
    
    private func setupTabBar() {
        var viewControllers: [UIViewController] = []
        
        for item in authService.navbarItems {
            let viewController = createViewController(for: item.action)
            viewController.tabBarItem = UITabBarItem(title: item.name, image: UIImage(systemName: item.icon), tag: 0)
            viewControllers.append(viewController)
        }
        self.viewControllers = viewControllers
    }
    
    private func createViewController(for action: String) -> UIViewController {
        switch action {
        case "main":
            return MainView()
        case "treatment":
            return TreatmentView()
        case "service":
            return ServiceView()
        case "chat":
            return ChatView()
        case "contact":
            return ContactsView()
        default:
            return UIViewController()
        }
    }
    
    private func setupTabBarAppearance() {
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor.blue
        UITabBar.appearance().isTranslucent = true
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
    }
}
