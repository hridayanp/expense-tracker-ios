import SwiftUI

struct ExpensesView: View {
    @StateObject private var viewModel = ExpensesViewModel()
    @EnvironmentObject var router: AppRouter // For navigation
    
    @State private var name: String = ""
    @State private var amount: String = ""
    @State private var selectedDate = Date() // State for DatePicker
    @State private var showAlert = false // State for success alert
    
    var body: some View {
        ZStack {
            // Background color
            AppColors.secondary
                .ignoresSafeArea()
            
            VStack {
                // Image at the top
                Image("linear-bg")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea()
                
                Spacer()
            }
            
            VStack {
                // Custom Navigation Bar (on top of the image)
                HStack {
                    Button(action: {
                        router.navigate(to: .mainTabs) // Navigate back
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(AppColors.primary) // Back button color
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
                .padding(.top, 50)
                .padding()
                
                Spacer()
                
                // Expense Entry Card
                VStack(spacing: 25) {
                    VStack(spacing: 10) {
                        Text("Name")
                            .foregroundColor(AppColors.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 22, weight: .bold))
                        
                        TextField("Enter name", text: $name, prompt: Text("Enter name").foregroundColor(AppColors.primary))
                            .padding()
                            .frame(height: 50)
                            .background(AppColors.secondary)
                            .cornerRadius(8)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(AppColors.primary)
                    }
                    
                    VStack(spacing: 10) {
                        Text("Date")
                            .foregroundColor(AppColors.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 22, weight: .bold))
                        
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .frame(maxWidth: .infinity, maxHeight: 50) // Ensures full width
                            .padding(.horizontal)
                            .background(AppColors.secondary)
                            .cornerRadius(8)
                    }
                    
                    VStack(spacing: 10) {
                        Text("Amount")
                            .foregroundColor(AppColors.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 22, weight: .bold))
                        
                        TextField("Enter amount", text: $amount, prompt: Text("Enter amount").foregroundColor(AppColors.primary))
                            .padding()
                            .frame(height: 50)
                            .background(AppColors.secondary)
                            .cornerRadius(8)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(AppColors.primary)
                            .keyboardType(.decimalPad)
                    }
                    
                    
                    
                    Button(action: addExpense) {
                        Text("Add")
                            .foregroundColor(AppColors.secondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(AppColors.primary)
                            .cornerRadius(10)
                            .padding(.top, 30)
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text("Expense added successfully!"), dismissButton: .default(Text("OK")) {
                router.navigate(to: .mainTabs) // Navigate back on alert dismiss
            })
        }
    }
    
    private func addExpense() {
        guard let amountValue = Float(amount), !name.isEmpty else { return }
        viewModel.addExpense(name: name, amount: amountValue, timestamp: selectedDate)
        name = ""
        amount = ""
        selectedDate = Date()
        showAlert = true // Show success alert
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView().environmentObject(AppRouter()) // Provide router for preview
    }
}
