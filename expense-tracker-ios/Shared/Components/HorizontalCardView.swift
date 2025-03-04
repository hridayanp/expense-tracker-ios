//
//  HorizontalCardView.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 04/03/25.
//

import SwiftUI

struct HorizontalCardView: View {
    let transaction: ExpensesModel
    
    var body: some View {
        HStack {
            // Leading Content (Title & Date)
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.system(size: 18, weight: .bold))
                
                Text(transaction.transactionDate)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Trailing Content (Amount)
            Text(transaction.amount)
                .font(.system(size: 18, weight: .bold))
        }
        .padding()
        .background(
            GlassmorphicBackground() // Applying the glass effect background
        )
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}
