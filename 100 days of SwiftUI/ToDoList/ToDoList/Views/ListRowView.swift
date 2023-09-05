//
//  ListRowView.swift
//  ToDoList
//
//  Created by Vakhtang Saginadze on 07.06.2023.
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel
    var body: some View {
        HStack {
            Image(systemName: item.isChecked ? "checkmark.circle" : "circle")
                .foregroundColor(item.isChecked ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var item1 = ItemModel(title: "First Item!", isChecked: true)
    static var item2 = ItemModel(title: "Second Item!", isChecked: false)
    static var previews: some View {
        Group {
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
