//
//  HomeView.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 04/03/25.
//


import SwiftUI

struct HomeView: View {
    
    let transactions: [ExpensesModel] = [
        ExpensesModel(id: 1, title: "Grocery Shopping", transactionDate: "Mar 2, 2025", amount: "-$120.50"),
        ExpensesModel(id: 2, title: "Salary", transactionDate: "Mar 1, 2025", amount: "+$2,500.00"),
        ExpensesModel(id: 3, title: "Netflix Subscription", transactionDate: "Feb 28, 2025", amount: "-$15.99"),
        ExpensesModel(id: 1, title: "Grocery Shopping", transactionDate: "Mar 2, 2025", amount: "-$120.50"),
        
    ]
    
    var body: some View {
        ParallaxScrollView(backgroundImage: "linear-bg-2") {
            VStack(spacing: 0) {
                // Card View with Expense Details
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Total Expenses")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text("$5,430")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.up.circle")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .background(Color.clear)
                                
                                Text("Income")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            
                            Text("$8,500")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 2) {
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.down.circle")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .background(Color.clear)
                                
                                Text("Expenses")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            
                            Text("$3,070")
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
                    Text("Transaction History")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(transactions) { transaction in
                                HorizontalCardView(transaction: transaction)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .frame(maxHeight: 400)
                .padding(.top, -120)
            }
        }
        .background(AppColors.secondary)
        
    }
}

#Preview {
    HomeView()
}
