//
//  ListRowView.swift
//  TodoList
//
//  Created by Abd Elrahman Atallah on 09/07/2024.
//

import SwiftUI

struct ListRowView: View  {
    let item : ItemModel
    
    var body: some View {
        HStack{
            Image(systemName:item.isCompleted ?  "checkmark.circle" : "circle")
                .foregroundStyle(item.isCompleted ? .green : .red)
            Text(item.title)
                .frame(maxWidth: .infinity,alignment: .leading)
                
            Spacer()
        }
        .font(.title2)
        .padding(.vertical,8)
    }
}

#Preview("Not completed title") {
    ListRowView(item: ItemModel(title: "This is the first item", isCompleted: false))
        .previewLayout(.sizeThatFits)
}
    

#Preview("completed title") {
    ListRowView(item: ItemModel(title: "This is the second item", isCompleted: true))
        .previewLayout(.sizeThatFits)
}
