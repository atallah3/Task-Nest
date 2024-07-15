//
//  TodoListApp.swift
//  TodoList
//
//  Created by Abd Elrahman Atallah on 09/07/2024.
//

import SwiftUI

@main
struct TodoListApp: App {
    
    @StateObject var listViewModel : ListViewModel = ListViewModel()
    @StateObject var detailRowViewModel : DetailRowViewModel = DetailRowViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ListView()
            }
            .environmentObject(listViewModel)
            .environmentObject(detailRowViewModel)
        }
    }
}
