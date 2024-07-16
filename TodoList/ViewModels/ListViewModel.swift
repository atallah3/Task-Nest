//
//  ListViewModel.swift
//  TodoList
//
//  Created by Abd Elrahman Atallah on 09/07/2024.
//

import Foundation


class ListViewModel : ObservableObject {
    
    @Published var items : [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    private let itemsKey : String = "itemsKey"
    
    @Published private var selectedItem: ItemModel?
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let savedData = UserDefaults().data(forKey: itemsKey),
            let savedDataAfterDecodeIt = try? JSONDecoder().decode([ItemModel].self, from: savedData)
        else { return }
        
        self.items = savedDataAfterDecodeIt
    }
    
    func deleteItem(indexSet: IndexSet) {
        indexSet.forEach { index in
            let deletedItem = items[index]
            items.remove(at: index)
            
            NotificationManager.shared.cancelNotification(withId: deletedItem.id)
        }
    }
    
    func moveItem(from : IndexSet ,to : Int ) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title :String) -> ItemModel {
        let newItem = ItemModel(id : UUID().uuidString, title: title, isCompleted: false)
        items.append(newItem)
        return newItem
    }
    
    func updateCompletness(item : ItemModel) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateItemCompleteness()
        }
    }
    
    func saveItems() {
        guard let encodedData = try? JSONEncoder().encode(items) else { return }
        UserDefaults().setValue(encodedData, forKey: itemsKey)
    }
}
