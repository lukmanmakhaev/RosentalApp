//
//  Indication.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 08.09.2024.
//

import Foundation

struct Indication: Codable {
    let type: String?
    let label: String?
    let lastTransfer: String?
    let expected: Bool?
    
    enum CodingKeys: String, CodingKey {
        case type, label
        case lastTransfer = "last_transfer"
        case expected
    }
}
