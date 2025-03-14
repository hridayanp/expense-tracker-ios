//
//  CustomButton.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 04/03/25.
//

import SwiftUI

enum ButtonType {
    case primary, secondary
}

struct CustomButton: View {
    var title: String
    var type: ButtonType
    var action: () -> Void
    var isDisabled: Bool = false
    var isLoading: Bool = false // New property for loading state
    
    var body: some View {
        Button(action: {
            if !isLoading {
                action()
            }
        }) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: type == .primary ? .black : .white))
                } else {
                    Text(title)
                }
            }
            .frame(maxWidth: 200)
            .padding()
            .background(type == .primary ? AppColors.primary : Color.clear) // Primary: White bg, Secondary: Transparent
            .foregroundColor(type == .primary ? Color.white : Color.black) // Primary: Black text, Secondary: White text
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 2) // White border for both types
            )
            .cornerRadius(8)
        }
        .disabled(isDisabled || isLoading) // Disable button while loading
        .opacity(isDisabled ? 0.5 : 1.0) // Reduce opacity when disabled or loading
    }
}
