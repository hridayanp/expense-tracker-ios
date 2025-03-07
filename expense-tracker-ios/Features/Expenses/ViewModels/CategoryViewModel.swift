//
//  CategoryViewModel.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 07/03/25.
//

import Foundation
import CoreData

class CategoryViewModel: ObservableObject {
    @Published var categories: [CategoryEntity] = []
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchCategories()
    }
    
    func fetchCategories() {
        let request: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print("Failed to fetch categories: \(error)")
        }
    }
    
    func addCategory(name: String) {
        let newCategory = CategoryEntity(context: context)
        let extractedEmoji = extractEmoji(from: name)
        
        newCategory.name = name.filter { !$0.isEmoji } // Remove emoji from name
        newCategory.emoji = extractedEmoji
        
        saveContext()
        fetchCategories() // Refresh UI
    }
    
    func deleteCategory(_ category: CategoryEntity) {
        context.delete(category)
        saveContext()
        fetchCategories() // Refresh UI
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save category: \(error)")
        }
    }
    
    // Extracts the first emoji from a string
    private func extractEmoji(from text: String) -> String {
        return text.first(where: { $0.isEmoji }).map(String.init) ?? ""
    }
}

extension Character {
    var isEmoji: Bool {
        unicodeScalars.contains { $0.properties.isEmoji && $0.value > 0x238C }
    }
}
