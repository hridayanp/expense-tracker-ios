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
}

class AppRouter: ObservableObject {
    @Published var currentRoute: AppRoute? = nil  // Holds current route
    
    func navigate(to route: AppRoute) {
        currentRoute = route
    }
}
