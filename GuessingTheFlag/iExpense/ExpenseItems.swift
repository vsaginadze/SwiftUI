//
//  ExpenseItems.swift
//  iExpense
//
//  Created by Vakhtang Saginadze on 06.06.2023.
//

import Foundation

class ExpenseItems: ObservableObject {
    @Published var items = [ExpenseItem]()
}
