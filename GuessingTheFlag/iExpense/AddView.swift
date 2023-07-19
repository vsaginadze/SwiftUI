//
//  AddView.swift
//  iExpense
//
//  Created by Vakhtang Saginadze on 06.06.2023.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: ExpenseItems
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var selectedCurrencyIndex = 0
    
    let types = ["Personal", "Business"]
    let currencies = ["USD", "EUR", "GPB", "JPY"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                HStack {
                    TextField("Amount", value: $amount, format: .currency(code: currencies[selectedCurrencyIndex]))
                    
                    Picker("", selection: $selectedCurrencyIndex) {
                        ForEach(0..<currencies.count) { index in
                            Text(currencies[index])
                        }
                    }
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                let item = ExpenseItem(name: name, type: type, currency: currencies[selectedCurrencyIndex], amount: amount)
                Button ("Save") {
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: ExpenseItems())
    }
}
