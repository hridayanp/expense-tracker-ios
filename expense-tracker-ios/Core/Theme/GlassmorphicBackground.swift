//
//  GlassmorphicBackground.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 04/03/25.
//

import SwiftUI

// MARK: - Blur View (For Glassmorphism)
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

// MARK: - Glassmorphic Background
struct GlassmorphicBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.clear) // Fully transparent background
            .background(
                BlurView(style: .light) // Subtle blur effect for frosted glass look
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1) // Softer border for visual separation
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
