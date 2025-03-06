//
//  HorizontalCardView.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 04/03/25.
//

import SwiftUI

struct HorizontalCardView: View {
    let transaction: ExpenseEntity // Change from ExpensesModel to ExpenseEntity
    
    var body: some View {
        HStack {
            // Leading Content (Title & Date)
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.name ?? "Unknown Expense")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(AppColors.primary)
                
                Text(formattedDate(transaction.timestamp))
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            // Trailing Content (Amount)
            Text("$\(transaction.amount, specifier: "%.2f")")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(AppColors.primary)
        }
        .padding()
        .background(
            GlassmorphicBackground() // Applying the glass effect background
        )
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
    
    // Helper function to format date
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "Unknown Date" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy" // Example: "Mar 2, 2025"
        return formatter.string(from: date)
    }
}
