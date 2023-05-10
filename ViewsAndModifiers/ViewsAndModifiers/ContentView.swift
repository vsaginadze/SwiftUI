//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Vakhtang Saginadze on 28.03.2023.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle)
    }
}

extension View {
    func prominentTitle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    var body: some View {
       Text("hello there")
            .prominentTitle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
