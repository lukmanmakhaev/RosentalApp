//
//  Expected.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 08.09.2024.
//

import Foundation

struct Expected: Codable {
    let lastDate: String?
    let indications: [Indication]?
    
    enum CodingKeys: String, CodingKey {
        case lastDate = "last_date"
        case indications
    }
}
