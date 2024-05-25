//
//  AddPetButton.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/23/24.
//

import SwiftUI

struct AddPetButton: View {
    
    @State var animate: Bool = false
    @State var toggleSheet = false
    
    var body: some View {
        
        Button { 
            toggleSheet.toggle()
        } label: { 
            Image(systemName: "pawprint")
                .foregroundStyle(Color.text)
                .font(.title)
                .bold()
                .frame(width: 55, height: 55)
                .background(animate ? Color.secondaryText : Color.accent)
                .clipShape(Circle())
        }
        .padding(.horizontal, animate ? 30 : 50)
        .shadow(color: animate ? Color.secondaryText.opacity(0.7) : Color.accent.opacity(0.7),
                radius: animate ? 30 : 10,
                y: animate ? 40 : 20)
        .scaleEffect(animate ? 1.2 : 1)
        .offset(y: animate ? -7 : 0)
        .frame(maxWidth: 400)
        .multilineTextAlignment(.center)
        .padding(40)
        .onAppear(perform: addAnimation)
        .sheet(isPresented: $toggleSheet, content: {
            Text("Add Pet")
        })
        
    }
    
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}


#Preview(traits: .fixedLayout(width: 100, height: 100)) {
    AddPetButton()
}

