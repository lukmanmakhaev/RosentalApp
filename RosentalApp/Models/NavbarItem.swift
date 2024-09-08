//
//  CustomerNavbarItem.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 05.09.2024.
//

import Foundation

struct NavbarItem: Codable {
    let name: String
    let action: String
    
    
    var icon: String {
        switch action {
        case "main":
            return "key.fill"
        case "treatment":
            return "checkmark.rectangle.portrait.fill"
        case "service":
            return "star.fill"
        case "chat":
            return "ellipsis.message.fill"
        case "contact":
            return "person.crop.circle.fill"
        default:
            return ""
        }
    }
}
