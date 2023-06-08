//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Vakhtang Saginadze on 07.06.2023.
//

import Foundation

/**
 CRUD FUNCTIONS
 
 Create
 Read
 Update
 Delete
 
 */

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = []
    
    init() {
        getItems()
    }
    
    func getItems() {
        let newItems = [
            ItemModel(title: "This is the first item.", isChecked: true),
            ItemModel(title: "This is second", isChecked: false),
            ItemModel(title: "The Third", isChecked: true)
        ]
        items.append(contentsOf: newItems)
    }
    
    func removeItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func moveItems(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let item = ItemModel(title: title, isChecked: false)
        items.append(item)
    }
    
    func updateItem(item: ItemModel) {        
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
}
