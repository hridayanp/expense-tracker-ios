//
//  HomeView.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 04/03/25.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @StateObject private var viewModel = ExpensesViewModel()
    
    var body: some View {
        ParallaxScrollView(backgroundImage: "linear-bg-2") {
            VStack(spacing: 0) {
                // Card View with Expense Details
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Total Expenses")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text("$\(calculateTotalExpenses(), specifier: "%.2f")")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.up.circle")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                
                                Text("Income")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            
                            Text("$8,500") // Dummy Income (Replace if needed)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 2) {
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.down.circle")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                
                                Text("Expenses")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            
                            Text("$\(calculateTotalExpenses(), specifier: "%.2f")")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .background(AppColors.primary)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.2), radius: 16, x: 0, y: -8)
                .padding(.horizontal, 16)
                .offset(y: -150) // Moves the card **100 points from the top**
                
                // Transaction History Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Expenses History")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                        .foregroundStyle(AppColors.primary)
                    
                    if viewModel.expenses.isEmpty {
                        Text("No Expenses Added")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                            .padding(.top, 20)
                    } else {
                        List {
                            ForEach(viewModel.expenses) { expense in
                                HorizontalCardView(transaction: expense)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                            }
                            .onDelete(perform: deleteExpense)
                        }
                        .listStyle(.plain)
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 350, maxHeight: .infinity)
                .background(AppColors.secondary)
                .cornerRadius(16)
                .padding(.top, -120)
            }
        }
        
        .background(AppColors.secondary)
        .onAppear {
            viewModel.fetchExpenses() // Fetch expenses on view appear
        }
    }
    
    // Helper function to calculate total expenses
    private func calculateTotalExpenses() -> Float {
        return viewModel.expenses.reduce(0) { $0 + ($1.amount) }
    }
    
    // Delete Expense function
    private func deleteExpense(at offsets: IndexSet) {
        offsets.forEach { index in
            let expense = viewModel.expenses[index]
            viewModel.deleteExpense(expense: expense)
        }
    }
}

#Preview {
    HomeView()
}
