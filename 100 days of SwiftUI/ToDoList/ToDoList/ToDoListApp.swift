//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Vakhtang Saginadze on 07.06.2023.
//

import SwiftUI

@main
struct ToDoListApp: App {
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
