//
//  ContentView.swift
//  MoonShot
//
//  Created by Vakhtang Saginadze on 19.07.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("cosmonaut")
                   .resizable()
                   .scaledToFit()
                   .frame(width: geo.size.width, height: geo.size.height)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
