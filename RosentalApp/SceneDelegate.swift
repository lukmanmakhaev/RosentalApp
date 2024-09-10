//
//  SceneDelegate.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 03.09.2024.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var authService = AuthService.shared
    var cancellables = Set<AnyCancellable>()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setupWindow(with: scene)
        observeAuthentication()
        checkAuthentication()
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    private func observeAuthentication() {
        authService.$isAuthenticated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isAuthenticated in
                self?.checkAuthentication()
            }
            .store(in: &cancellables)
    }
    
    public func checkAuthentication() {
        if authService.isAuthenticated == true {
            self.goToController(viewController: MainTabBarController())
        } else {
            self.goToController(viewController: WelcomeView())
        }
    }
    
    func goToController(viewController: UIViewController) {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = self.window?.center ?? CGPoint(x: 0, y: 0)
        activityIndicator.startAnimating()
        
        DispatchQueue.main.async { [weak self] in
            if let window = self?.window {
                window.addSubview(activityIndicator)
            }
            
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
            } completion: { [weak self] _ in
                let nav = UINavigationController(rootViewController: viewController)
                nav.setNavigationBarHidden(true, animated: false)  // Hide the navigation bar

                nav.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = nav

                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                } completion: { _ in
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                }
            }
        }
    }
}

