//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 02.11.2023.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 75), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode:.fit)
                }
            }
        }
    }
    
    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat
    {
        let count = CGFloat(count)
        var columnCount = 1.0
        var gridSize: CGFloat

        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            print(width)
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                gridSize = (size.width / columnCount).rounded(.down)
                print((size.width / columnCount).rounded(.down))
            }
            columnCount += 1
        } while columnCount < count
        gridSize = min(size.width / count, size.height * aspectRatio).rounded(.down)

        return gridSize
    }
}
