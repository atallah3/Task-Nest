//
//  ItemModel.swift
//  TodoList
//
//  Created by Abd Elrahman Atallah on 09/07/2024.
//

import Foundation


struct ItemModel : Hashable , Codable {
    let id : String
    let title : String
    let isCompleted : Bool 
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
 
    func updateItemCompleteness() -> ItemModel{
        ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
