//
//  AuthViewModel.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 05.09.2024.
//

import Foundation
import Combine

final class AuthService {
    public static let shared = AuthService()
    
    @Published var isAuthenticated: Bool {
        didSet {
            if oldValue != isAuthenticated {
                UserDefaults.standard.set(isAuthenticated, forKey: "isAuthenticated")
            }
        }
    }
    var cancellables = Set<AnyCancellable>()
    var loginResponse: LoginResponse?
    var navbarItems: [NavbarItem] = []

    init() {
        isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
        loadNavbarItems()
    }
    
    func login(email: String, password: String) {
        Task {
            do {
                let response = try await NetworkService.shared.login(username: email, password: password)
                DispatchQueue.main.async {
                    if response.login == "ok" {
                        self.saveNavbarItems(response.customerNavbar)
                        self.loadNavbarItems()
                        self.isAuthenticated = true
                        self.loginResponse = response
                    } else {
                        self.isAuthenticated = false
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Login error: \(error.localizedDescription)")
                    self.isAuthenticated = false
                }
            }
        }
    }
    
    func logout() {
        isAuthenticated = false
    }
    
    private func saveNavbarItems(_ items: [NavbarItem]) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(items)
            UserDefaults.standard.set(encoded, forKey: "navbarItems")
        } catch {
            print("Failed to encode navbar items: \(error)")
        }
    }
    
    func loadNavbarItems() {
        if let data = UserDefaults.standard.data(forKey: "navbarItems") {
            let decoder = JSONDecoder()
            do {
                let items = try decoder.decode([NavbarItem].self, from: data)
                self.navbarItems = items

            } catch {
                print("Failed to decode navbar items: \(error)")
            }
        }
    }
}
