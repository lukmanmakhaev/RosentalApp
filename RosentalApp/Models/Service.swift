//
//  Service.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 08.09.2024.
//

import Foundation

struct Service: Codable {
    let name: String
    let action: String
    let order: Int
    
    var icon: String {
        switch action {
        case "docs":
            return "camera"
        case "offer":
            return "car.fill"
        case "poll":
            return "star.fill"
        case "cleaning":
            return "lightbulb"
        case "basip":
            return "person.crop.circle.fill"
        case "vote":
            return "person.crop.circle.fill"
        case "pass":
            return "person.crop.circle.fill"
        default:
            return ""
        }
    }
}
