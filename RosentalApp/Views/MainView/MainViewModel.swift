//
//  MainViewModel.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 08.09.2024.
//

import Foundation
import UIKit
import Combine

final class MainViewModel {
    let authService = AuthService.shared
    @Published var dashboard: DashboardResponse?

    init() {
        getDashboard()
    }

    func getDashboard() {
        Task {
            do {
                let newDashboard = try await NetworkService.shared.getDashboard()
                DispatchQueue.main.async {
                    self.dashboard = newDashboard
                }
            } catch {
                DispatchQueue.main.async {
                    print("Dashboard error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
}

