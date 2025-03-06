import Foundation
import CoreData

class ExpensesViewModel: ObservableObject {
    @Published var expenses: [ExpenseEntity] = []
    private let viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = context
        fetchExpenses()
    }
    
    func fetchExpenses() {
        let request: NSFetchRequest<ExpenseEntity> = ExpenseEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ExpenseEntity.timestamp, ascending: false)]
        
        do {
            expenses = try viewContext.fetch(request)
        } catch {
            print("Failed to fetch expenses: \(error.localizedDescription)")
        }
    }
    
    func addExpense(name: String, amount: Float, timestamp: Date, category: String) { // Accepts user-provided timestamp
        let newExpense = ExpenseEntity(context: viewContext)
        newExpense.name = name
        newExpense.amount = amount
        newExpense.category = category
        newExpense.timestamp = timestamp // Uses the provided timestamp
        
        saveContext()
        fetchExpenses()
    }
    
    func updateExpense(expense: ExpenseEntity, newName: String, newAmount: Float) {
        expense.name = newName
        expense.amount = newAmount
        saveContext()
        fetchExpenses()
    }
    
    func deleteExpense(expense: ExpenseEntity) {
        viewContext.delete(expense)
        saveContext()
        fetchExpenses()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
}
