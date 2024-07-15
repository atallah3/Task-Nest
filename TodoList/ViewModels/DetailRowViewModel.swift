//
//  DetailRowViewModel.swift
//  TodoList
//
//  Created by Abd Elrahman Atallah on 10/07/2024.
//

import Foundation


class DetailRowViewModel : ObservableObject{
    @Published var notesItems : [ItemModel] = [] {
        didSet {
            saveChanges()
        }
    }
    
    private let notesItemKey : String = "notesItemsKey"
    
    init() {
        addItem()
    }
    
    func addItem() {
        guard
            let savedData = UserDefaults().data(forKey: notesItemKey) ,
            let savedDataAfterDecodeIt = try? JSONDecoder().decode([ItemModel].self, from: savedData)
        else {return}
        
        self.notesItems = savedDataAfterDecodeIt
        
    }
    
    func saveChanges() {
        let encodedData = try? JSONEncoder().encode(notesItems)
        UserDefaults.standard.setValue(encodedData, forKey: notesItemKey)
    }
    
    func deleteItem(indexSet : IndexSet) {
        notesItems.remove(atOffsets: indexSet)
    }
    
    func updateCompletness(item : ItemModel) {
        if let index = notesItems.firstIndex(where: {$0.id == item.id}) {
            notesItems[index] = item.updateItemCompleteness()
        }
    }
}
