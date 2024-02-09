//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Vakhtang Saginadze on 09.02.2024.
//

import SwiftUI

struct FlyingNumber: View {
    typealias Card = MemoryGame<String>.Card
    
    let number:  Int
    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
