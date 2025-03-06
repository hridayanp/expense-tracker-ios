import SwiftUI

struct ExpensesView: View {
    @StateObject private var viewModel = ExpensesViewModel()
    @EnvironmentObject var router: AppRouter // For navigation
    
    @State private var name: String = ""
    @State private var amount: String = ""
    @State private var selectedCategory: String = "Select Category"
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var showCategorySheet = false
    
    // Dynamic category list
    private let categories: [(name: String, emoji: String)] = [
        ("Food", "🍔"),
        ("Pets", "🐶"),
        ("Transport", "🚗"),
        ("Household", "🏠"),
        ("Apparel", "👕")
    ]
    
    var body: some View {
        ZStack {
            AppColors.secondary
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 10) {
                    // Name Input
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(AppColors.primary)
                        
                        TextField("Enter name", text: $name, prompt: Text("Enter name").foregroundColor(AppColors.primary))
                            .padding()
                            .frame(height: 50)
                            .background(AppColors.secondary)
                            .cornerRadius(8)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(AppColors.primary)
                    }
                    
                    // Date Picker
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Date")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(AppColors.primary)
                        
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(AppColors.secondary)
                            .cornerRadius(8)
                    }
                    
                    // Amount Input
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Amount")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(AppColors.primary)
                        
                        TextField("Enter amount", text: $amount, prompt: Text("Enter amount").foregroundColor(AppColors.primary))
                            .padding()
                            .frame(height: 50)
                            .background(AppColors.secondary)
                            .cornerRadius(8)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(AppColors.primary)
                            .keyboardType(.decimalPad)
                    }
                    
                    // Category Selection (Opens Bottom Sheet)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Category")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(AppColors.primary)
                        
                        Button(action: {
                            showCategorySheet.toggle()
                        }) {
                            HStack {
                                Text(selectedCategory)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(AppColors.primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(AppColors.primary)
                            }
                            .padding()
                            .frame(height: 50)
                            .background(AppColors.secondary)
                            .cornerRadius(8)
                        }
                    }
                    
                    // Add Expense Button
                    Button(action: addExpense) {
                        Text("Add")
                            .foregroundColor(AppColors.secondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(AppColors.primary)
                            .cornerRadius(10)
                            .padding(.top, 15)
                            .font(.system(size: 18, weight: .medium))
                    }
                }
                .padding()
                .frame(height: 500)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppColors.primary, lineWidth: 2)
                )
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
        .sheet(isPresented: $showCategorySheet) {
            CategorySelectionSheetView(selectedCategory: $selectedCategory, showSheet: $showCategorySheet, categories: categories)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text("Expense added successfully!"), dismissButton: .default(Text("OK")) {
                router.navigate(to: .mainTabs)
            })
        }
    }
    
    private func addExpense() {
        guard let amountValue = Float(amount), !name.isEmpty, selectedCategory != "Select Category" else { return }
        viewModel.addExpense(name: name, amount: amountValue, timestamp: selectedDate, category: selectedCategory)
        name = ""
        amount = ""
        selectedCategory = "Select Category"
        selectedDate = Date()
        showAlert = true
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView().environmentObject(AppRouter())
    }
}
