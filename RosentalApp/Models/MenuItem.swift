//
//  MenuItem.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 08.09.2024.
//

import Foundation

struct MenuItem: Codable {
    let action: String
    let name: String
    let description: String
    let arrear: String?
    let amountCoins: Int?
    let expected: Expected?
    
    enum CodingKeys: String, CodingKey {
        case action, name, description, arrear
        case amountCoins = "amount_coins"
        case expected
    }
}
