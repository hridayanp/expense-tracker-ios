//
//  expense_tracker_iosApp.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 04/03/25.
//

import SwiftUI

@main
struct expense_tracker_iosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
