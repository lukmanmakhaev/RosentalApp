//
//  RootViewController.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 05.09.2024.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    var viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkAuthentication()
    }
    
    func checkAuthentication() {
        showScreen(isLoggedIn: viewModel.isAuthenticated)
    }
    
    func showScreen(isLoggedIn: Bool) {
        let mainTabbarView = MainTabBarController()
        let welcomeView = WelcomeView()
        welcomeView.viewModel = viewModel
        
        let newViewController = isLoggedIn ? mainTabbarView : welcomeView
        switchViewController(to: newViewController)
    }
    
    func switchViewController(to newViewController: UIViewController) {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }

        addChild(newViewController)
        newViewController.view.frame = view.bounds
        view.addSubview(newViewController.view)
        newViewController.didMove(toParent: self)
    }
}
