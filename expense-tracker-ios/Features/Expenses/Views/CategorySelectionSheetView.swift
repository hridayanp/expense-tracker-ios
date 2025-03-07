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
    @ObservedObject var viewModel: CategoryViewModel
    
    @State private var showAddCategoryAlert = false
    @State private var newCategoryName = ""
    
    var body: some View {
        VStack {
            Text("Select a Category")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        Button(action: {
                            let categoryText = "\(category.emoji ?? "") \(category.name ?? "")"
                            selectedCategory = categoryText.trimmingCharacters(in: .whitespaces)
                            showSheet = false
                        }) {
                            VStack {
                                Text(category.emoji ?? "")
                                    .font(.largeTitle)
                                Text(category.name ?? "")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.black)
                            }
                            .frame(height: 100)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                        }
                        .onLongPressGesture {
                            deleteCategoryAlert(for: category)
                        }
                    }
                    
                    // "Add" Category Card
                    Button(action: {
                        showAddCategoryAlert = true
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
        .alert("New Category", isPresented: $showAddCategoryAlert) {
            TextField("Enter category name", text: $newCategoryName)
            Button("Add", action: addCategory)
            Button("Cancel", role: .cancel, action: {})
        } message: {
            Text("Type a category name. If you include an emoji, it will be used as the category icon.")
        }
    }
    
    private func addCategory() {
        guard !newCategoryName.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        viewModel.addCategory(name: newCategoryName)
        newCategoryName = "" // Reset input field
    }
    
    private func deleteCategoryAlert(for category: CategoryEntity) {
        guard let categoryName = category.name else { return }
        
        let alert = UIAlertController(title: "Delete Category",
                                      message: "Are you sure you want to delete \(categoryName)?",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            viewModel.deleteCategory(category)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = scene.windows.first?.rootViewController {
            rootVC.present(alert, animated: true)
        }
    }
}
