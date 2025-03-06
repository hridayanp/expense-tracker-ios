//
//  MainView.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 04/03/25.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var router = AppRouter()
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                if let route = router.currentRoute {
                    
                    switch route {
                        case .mainTabs:
                            MainTabView()
                            
                        case .startingScreen:
                            AuthView()
                        
                        case .expensesView:
                            ExpensesView()
                    }
                } else {
                    AuthView()
                }
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    MainView()
}
