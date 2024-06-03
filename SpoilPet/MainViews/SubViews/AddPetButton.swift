    //
    //  AddPetButton.swift
    //  SpoilPet
    //
    //  Created by Alex Ryan on 5/23/24.
    //

import SwiftUI
import SwiftData

struct AddPetButton: View {
    @Environment(\.modelContext) var modelContext

    @State var animate: Bool = false

    var body: some View {
        Image(systemName: "pawprint")
            .foregroundStyle(Color.text)
            .font(.title)
            .bold()
            .frame(width: 55, height: 55)
            .background(animate ? Color.accent : Color.hero)
            .clipShape(Circle())
            .shadow(color: animate ? Color.accent.opacity(0.7) : Color.hero.opacity(0.7),
                    radius: animate ? 30 : 10,
                    y: animate ? 40 : 20)
            .scaleEffect(animate ? 1.2 : 1)
            .offset(y: animate ? -7 : 0)
            .onAppear(perform: addAnimation)
    }
        //    func addPet() {
        //        let pet = PetProfile(petName: "", petPhoto: nil, breed: "", sex: nil, species: nil, age: nil, weight: nil)
        //        modelContext.insert(pet)
        //        path.append(pet)
        //    }
        //
        //    func deletePet(at offsets: IndexSet) {
        //        for offset in offsets {
        //            let pet = pets[offset]
        //            modelContext.delete(pet)
        //        }
        //    }


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

struct AddPetButtonNonAnimated: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: "pawprint")
                    .foregroundStyle(Color.text)
                    .font(.title)
                    .bold()
                    .frame(width: 55, height: 55)
                    .background(Color.hero)
                    .clipShape(Circle())
                    .shadow(color: Color.hero.opacity(0.7), radius: 10, y: 20)
                .scaleEffect(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        .padding(.bottom, 110)
        .padding(.horizontal, 20)
    }
    
}

#Preview(traits: .fixedLayout(width: 100, height: 100)) {
    VStack {
        AddPetButton()
        AddPetButtonNonAnimated()
    }
}

