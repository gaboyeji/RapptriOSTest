//
//  ButtonLabel.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 7/29/22.
//

import Foundation

/*
 // MARK: From UIKit.Control
 case center = 0
 case left = 1
 case right = 2
 case fill = 3
 */
struct ButtonLabel {
    let title: String
    let color_text: Int
    let color_bg: Int
    let icon: String
    let masksToBounds: Bool
    let cornerRadius: Double
    let icon_size: Double
    let padding_left: Double
    let isDefault: Bool
    
    init(
        title: String,
        color_text: Int,
        color_bg: Int,
        icon: String,
        masksToBounds: Bool = false,
        cornerRadius: Double = 0.0,
        icon_size: Double = 24,
        padding_left: Double = 22,
        isDefault: Bool = true
    ) {
        self.title = title
        self.color_text = color_text
        self.color_bg = color_bg
        self.icon = icon
        self.masksToBounds = masksToBounds
        self.cornerRadius = cornerRadius
        self.icon_size = icon_size
        self.padding_left = padding_left
        self.isDefault = isDefault
    }
}
