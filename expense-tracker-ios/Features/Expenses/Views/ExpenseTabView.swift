//
//  ExpenseTabView.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 06/03/25.
//

import SwiftUI

struct ExpenseTabView: View {
    enum ExpenseViewTabs {
        case expenses
        case income
    }
    
    @State private var selectedTab: ExpenseViewTabs = .expenses
    @State private var screenHeading: String = ""
    
    init(defaultTab: ExpenseViewTabs) {
        _selectedTab = State(initialValue: defaultTab)
        _screenHeading = State(initialValue: defaultTab == .expenses ? "Expense" : "Income")
    }
    
    var body: some View {
        BaseView(backgroundColor: AppColors.secondary) {
            ZStack {
//                VStack {
//                    Image("linear-bg")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: .infinity)
//                        .ignoresSafeArea()
//                    
//                    Spacer()
//                }
                
                
                VStack {
                    HStack {
                        Spacer()
                        Text(screenHeading)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(AppColors.primary)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Button(action: {
                            selectedTab = .expenses
                            screenHeading = "Expense"
                            
                        }) {
                            Text("Expense")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(selectedTab == .expenses ? AppColors.secondary : nil)
                                .foregroundColor(selectedTab == .expenses ? AppColors.primary : AppColors.secondary)
                                .cornerRadius(8)
                                .foregroundStyle(.white)
                        }
                        
                        Button(action: {
                            selectedTab = .income
                            screenHeading = "Income"
                        }) {
                            Text("Income")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(selectedTab == .income ? AppColors.secondary : nil)
                                .foregroundColor(selectedTab == .income ? AppColors.primary : AppColors.secondary)
                                .cornerRadius(8)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(4)
                    .background(AppColors.primary)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    
                    if selectedTab == .expenses {
                        
                        ExpensesView()
                        
                    }
                    else {
                        IncomeView()
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ExpenseTabView(defaultTab: .expenses)
}
