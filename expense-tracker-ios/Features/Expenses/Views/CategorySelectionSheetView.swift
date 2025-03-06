//
//  CategorySelectionSheetView.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 06/03/25.
//

import SwiftUI




struct CategorySelectionSheetView: View {
    @Binding var selectedCategory: String
    @Binding var showSheet: Bool
    let categories: [(name: String, emoji: String)]
    
    var body: some View {
        VStack {
            Text("Select a Category")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(categories, id: \.name) { category in
                        Button(action: {
                            selectedCategory = "\(category.emoji) \(category.name)"
                            showSheet = false
                        }) {
                            VStack {
                                Text(category.emoji)
                                    .font(.largeTitle)
                                Text(category.name)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.black)
                            }
                            .frame(height: 100)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                        }
                    }
                    
                    // "Add" Category Card
                    Button(action: {
                        // Future functionality to add a new category
                    }) {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(AppColors.primary)
                            Text("Add")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.black)
                        }
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                    }
                }
                .padding()
            }
            
            Button("Close") {
                showSheet = false
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColors.primary)
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .padding()
        .background(AppColors.secondary.ignoresSafeArea())
    }
}
