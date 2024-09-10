//
//  DashboardResponse.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 08.09.2024.
//

import Foundation

struct DashboardResponse: Codable {
    let myNewNotifications: Int
    let myProfile: MyProfile
    let customerDashboard: CustomerDashboard
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case myNewNotifications = "my_new_notifications"
        case myProfile = "my_profile"
        case customerDashboard = "customer_dashboard"
        case code
    }
}

