//
//  AppColor.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 04/03/25.
//

import SwiftUI

struct AppColors {
    static let primary = Color(hex: 0x722F37)
    static let secondary = Color(hex: 0xEFDFBB)
}

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double((hex >> 0) & 0xFF) / 255,
            opacity: opacity
        )
    }
}
