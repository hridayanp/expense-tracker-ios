//
//  ExpensesModel.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 04/03/25.
//

import Foundation

struct ExpensesModel: Identifiable {
    let id: Int
    let title: String
    let transactionDate: String
    let amount: String
}
