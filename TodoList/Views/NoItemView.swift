//
//  NoItemView.swift
//  TodoList
//
//  Created by Abd Elrahman Atallah on 09/07/2024.
//

import SwiftUI

struct NoItemView: View {
    @State var animate : Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    var body: some View {
       
            VStack(spacing : 10 ) {
                Spacer()
                Text("there is no items!".uppercased())
                    .font(.title)
                    .fontWeight(.semibold)
                    
                Text("Are you a productive person? I think you should click the add button and add a bunch of items to your todo list!")
                    .font(.subheadline)
                
                NavigationLink(destination: AddItemView(), label: {
                    Text("Add Something 🤩")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? secondaryAccentColor : .accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, animate ? 50 : 30)
                })
                    .offset( y: animate ? -7 : 0)
                    .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : .accentColor.opacity(0.7),
                            radius: 20,
                            x: 0,
                            y: animate ? 30 : 50)
                Spacer()
                Spacer()
            }
            .padding(40)
            
        
        .multilineTextAlignment(.center)
        .onAppear(perform: addAnimation)
    }
    
    
    func addAnimation() {
        guard !animate else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ) {
            withAnimation(
                Animation
                    .easeInOut(duration: 1.5)
                    .repeatForever()
            ) {
                animate.toggle()
            }
            
        }
    }
}

#Preview {
    NavigationStack{
        NoItemView()
            .navigationTitle("")
            .environmentObject(ListViewModel())
    }
}
