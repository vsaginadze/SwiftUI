//
//  ContentView.swift
//  iExpense
//
//  Created by Vakhtang Saginadze on 26.05.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var expenses = ExpenseItems()
    @State private var showAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddView) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
