//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 09.02.2024.
//

import SwiftUI

struct FlyingNumber: View {
    typealias Card = MemoryGame<String>.Card
    @State private var offset: CGFloat = 0
    let number:  Int
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundStyle(number < 0 ? .red : .green)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 1.5, x: 1, y: 1)
                .fontWeight(.semibold)
                .opacity(offset != 0 ? 0 : 1)
                .offset(x: 0, y: offset)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.6)) {
                        offset = number < 0 ? 200 : -200
                    }
                }
                .onDisappear {
                    offset = 0
                }
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
