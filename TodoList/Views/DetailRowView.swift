//
//  DetailRowView.swift
//  TodoList
//
//  Created by Abd Elrahman Atallah on 10/07/2024.
//\



//List {
//    ForEach(notesItems,id: \.self) { item in
//        ListRowView(item: item)
//    }
//}
//.listStyle(.plain)


//
//TextField("Add your NOTES here..", text: $notesText)
//    .padding()
//    .frame(height: 55)
//    .background(Color.gray.opacity(0.3))
//    .clipShape(RoundedRectangle(cornerRadius: 10))
import SwiftUI

struct DetailRowView: View {
    
    @State var notesText : String = ""
    @ObservedObject var viewModel : DetailRowViewModel = DetailRowViewModel()
    
    let title : String
    var body: some View {
        VStack{
                TextField("Add your NOTES here..", text: $notesText)
                    .padding()
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            
            .padding(.horizontal)
            
            
            if viewModel.notesItems.isEmpty {
                ContentUnavailableView("Add New Tasks", systemImage: "square.and.pencil", description: Text("Organize your to-dos by adding detailed subtasks like: Step 1, Step 2"))
            }
            
            List {
                ForEach(viewModel.notesItems,id: \.self) { item in
                    ListRowView(item: item)
                        .onTapGesture {
                            withAnimation(.easeIn){
                                viewModel.updateCompletness(item: item)
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button(item.isCompleted ? "Uncheck" : "Done") {
                                withAnimation(.easeOut(duration: 0.3)){
                                    viewModel.updateCompletness(item: item)
                                }
                                
                            }
                            .tint(!item.isCompleted ? .green : .red)
                            
                            
                        }
                }
                .onDelete(perform: viewModel.deleteItem)
            }
            .listStyle(.plain)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing,content: saveButton)
        }
        .navigationTitle(title)
    }
    
    private func saveButton() -> some View {
        Button(action: {
            if textIsValid() { 
                viewModel.notesItems.append(ItemModel(title: notesText, isCompleted: false))
                notesText = ""
            }
        }, label: {
            Text("save".uppercased())
        })
    }
    
    func textIsValid()-> Bool {
        if notesText.isEmpty {return false}
        return true
    }
}

#Preview {
    NavigationStack{
        DetailRowView(title: "notes")
            .environmentObject(DetailRowViewModel())
    }
}
