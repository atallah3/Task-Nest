//
//  ListView.swift
//  TodoList
//
//  Created by Abd Elrahman Atallah on 09/07/2024.
//

import SwiftUI

struct ListView: View {
    
    //MARK: -  PROPERTIES
    
    @EnvironmentObject var listViewModel : ListViewModel
    @State var showSheet : Bool = false
    
    //MARK: - VIEWS
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty { 
                NoItemView()
                    .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            List {
                ForEach(listViewModel.items,id: \.self) { item in
                    NavigationLink(destination: DetailRowView(title: item.title)) {
                        ListRowView(item: item)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button(item.isCompleted ? "Uncheck" : "Done") {
                            withAnimation(.easeOut(duration: 0.3)){
                                listViewModel.updateCompletness(item: item)
                            }
                            
                        }
                        .tint(!item.isCompleted ? .green : .red)
                        
                        
                    }
                }
                .onDelete(perform: listViewModel.deleteItem)
                .onMove(perform: listViewModel.moveItem)
            }
            .listStyle(.plain)
        }
        .navigationTitle("Todo List 📝")
        .toolbar{
            ToolbarItem(placement: .topBarLeading) { 
                if !listViewModel.items.isEmpty {  EditButton() }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Text("Add")
                    .onTapGesture {
                        showSheet.toggle()
                    }
            }
        }
        .sheet(isPresented: $showSheet) {
            AddItemView()
        }
    }
    
   //MARK: - FUNCTIONS
    
}

#Preview {
    NavigationStack{
        ListView()
            .environmentObject(ListViewModel())
    }
    
}


