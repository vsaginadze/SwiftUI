//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Vakhtang Saginadze on 06.06.2023.
//

import Foundation

struct ExpenseItem: Identifiable {
    var id = UUID()
    let name: String
    let type: String
    let amonut: Double
}
