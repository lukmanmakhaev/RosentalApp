//
//  UILabel+ext.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 04.09.2024.
//

import UIKit

extension UILabel {
    func getTextSize() -> CGSize {
        guard let text else { return CGSize() }
        let fontName = font.fontName
        let fontSize = font.pointSize
        let font = UIFont(name: fontName, size: fontSize)
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = text.size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
        return CGSize(width: size.width.rounded(), height: size.height.rounded())
    }
}
