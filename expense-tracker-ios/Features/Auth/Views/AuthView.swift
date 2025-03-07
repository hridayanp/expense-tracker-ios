//
//  AuthView.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 05/03/25.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        BaseView(backgroundColor: AppColors.secondary) {
            VStack {
                Spacer()
                
                Text("Spend Smarter")
                    .foregroundStyle(AppColors.primary)
                    .font(.system(size: 40, weight: .bold, design: .default))
                
                Text("Save More")
                    .foregroundStyle(AppColors.primary)
                    .font(.system(size: 40, weight: .bold, design: .default))
                
                CustomButton(title: "Get Started", type: .primary) {
                    router.navigate(to: .mainTabs)
                }
            }
            .padding()
        }
    }
}

#Preview {
    AuthView()
}
