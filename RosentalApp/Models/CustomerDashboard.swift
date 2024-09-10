//
//  CustomerDashboard.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 08.09.2024.
//

import Foundation

struct CustomerDashboard: Codable {
    
    let date: String?
    let notifications: Notificationss?
    let menuItems: [MenuItem]?
    let banners: [Banner]?
    let services: [Service]?
    let navbar: [NavbarItem]?
    
    enum CodingKeys: String, CodingKey {
        case date, notifications
        case menuItems = "menu_items"
        case banners, services, navbar
    }

}
