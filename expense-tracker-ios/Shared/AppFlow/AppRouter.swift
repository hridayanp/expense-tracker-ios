//
//  AppRouter.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 04/03/25.
//

import Foundation

import Foundation

enum AppRoute {
    case startingScreen
    case mainTabs
    case expensesView
}

class AppRouter: ObservableObject {
    @Published var currentRoute: AppRoute? = nil
    
    func navigate(to route: AppRoute) {
        currentRoute = route
    }
    
    func goToExpensesView() {
        currentRoute = .expensesView
    }
    
    func goToMainTabs() {
        currentRoute = .mainTabs
    }
}
