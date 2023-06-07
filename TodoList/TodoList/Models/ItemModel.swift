//
//  ItemModel.swift
//  ToDoList
//
//  Created by Vakhtang Saginadze on 07.06.2023.
//

import Foundation

struct ItemModel: Identifiable {
    var id: String = UUID().uuidString
    let title: String
    let isChecked: Bool
}
