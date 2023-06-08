//
//  ItemModel.swift
//  ToDoList
//
//  Created by Vakhtang Saginadze on 07.06.2023.
//

import Foundation

struct ItemModel: Identifiable {
    var id: String
    let title: String
    let isChecked: Bool
    
    init(id: String = UUID().uuidString, title: String, isChecked: Bool) {
        self.id = id
        self.title = title
        self.isChecked = isChecked
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isChecked: !isChecked)
    }
}

