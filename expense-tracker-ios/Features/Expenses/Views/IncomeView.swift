//
//  IncomeView.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 06/03/25.
//

import SwiftUI

struct IncomeView: View {
    var body: some View {
        ZStack {
            AppColors.secondary.ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                
                VStack(spacing: 10) {
                    VStack {
                        Text("Hello, World!")
                    }
                    
                    
                }
                .padding()
                .frame(height: 500)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppColors.primary, lineWidth: 2)
                )
                .padding(.horizontal, 24)
                
                Spacer()
            }
            
            
        }
    }
}

#Preview {
    IncomeView()
}
