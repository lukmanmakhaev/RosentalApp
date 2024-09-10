//
//  LoginResponse.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 05.09.2024.
//

import Foundation

struct LoginResponse: Codable {
    let login: String
    let customerNavbar: [NavbarItem]
    let code: Int

    enum CodingKeys: String, CodingKey {
        case login
        case customerNavbar = "customer_navbar"
        case code
    }
}
