//
//  MainTabBarController.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 05.09.2024.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    var navbarItems: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        var viewControllers: [UIViewController] = []
        
        for item in navbarItems {
            guard let name = item["name"], let action = item["action"] else { continue }
            
            let viewController = createViewController(for: action)
            viewController.tabBarItem = UITabBarItem(title: name, image: UIImage(systemName: "star"), tag: 0)
            
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
            return ContactView()
        default:
            return UIViewController()
        }
    }
}
