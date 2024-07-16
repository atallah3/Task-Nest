//
//  AddItemView.swift
//  TodoList
//
//  Created by Abd Elrahman Atallah on 09/07/2024.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var listViewModel : ListViewModel
    
    @State var itemTF : String = ""
    
    @State var showAlert : Bool = false
    @State var alertTitle : String = ""
    
    @State var date : Date = Date()
    
    var body: some View {
        ScrollView{
            VStack(spacing: 30) {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 20, height: 2, alignment: .center)
                
                Text("Add an item 🖋️")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                TextField("Add Item Here...", text: $itemTF)
                    .padding()
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                DatePicker("Select a reminder", selection: $date, displayedComponents: [.hourAndMinute])
                
                Button(action: saveItem , label: {
                    Text("Save".uppercased())
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.tint)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                })
                
                
               
                    
            }
            .padding()
        }
        
        .alert(alertTitle, isPresented: $showAlert) {}
    }
    
    
    func saveItem() {
        if !textIsValid() {
            alertTitle = "Please enter more than 3 characters 🤪"
            showAlert.toggle()
            return
        }
        
       let newItem = listViewModel.addItem(title: itemTF)

        NotificationManager.shared.requestAuthurization()
        NotificationManager.shared.schduleNotification(id: newItem.id , title: itemTF, date: date)
        
        dismiss()
    }
    
    func textIsValid() -> Bool{
        if itemTF.count > 3 {
            return true
        }
        return false
    }
}

#Preview {
    NavigationStack{
        AddItemView()
            .environmentObject(ListViewModel())
    }
}
