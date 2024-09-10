//
//  MyProfile.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 08.09.2024.
//

import Foundation

struct MyProfile: Codable {
    let id, name, shortName, firstName: String
    let lastName, secondName, email, phone: String
    let photo: String?
    let property, address: String?
    let rating: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case shortName = "short_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case secondName = "second_name"
        case email, phone, photo, property, address, rating
    }
}
