    //
    //  PetsView.swift
    //  SpoilPet
    //
    //  Created by Alex Ryan on 5/24/24.
    //

import SwiftUI
import SwiftData
import SDWebImageSwiftUI

struct PetsView: View {
    @Environment(\.modelContext) var context

    @Query(sort: \PetProfile.petName) var pets: [PetProfile] = []
    @State var toggleSheet = false
    @State private var petToEdit: PetProfile?

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                    List {
                        Spacer()
                            .listRowBackground(Color.background)
                        ForEach(pets) { pet in
                            PetCell(pet: pet)
                                .listRowInsets(EdgeInsets())
                                .onTapGesture {
                                    petToEdit = pet
                                }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                context.delete(pets[index])
                            }
                        }
                    }
                    .background(Color.background)
                    .scrollContentBackground(.hidden)
                    .listRowBackground(Color.background)
                    .listRowSpacing(12)
                    .listRowSeparator(.hidden)
                    .navigationTitle("My Pets")
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarBackground(.hero, for: .navigationBar)
                    .sheet(isPresented: $toggleSheet, content: {
                        PetDetailsSheet()
                    })
                    .sheet(item: $petToEdit) { pet in
                        UpdatePetDetailsSheet(pet: pet)
                }

                    //pet Button
                if !pets.isEmpty {
                        AddPetButtonNonAnimated()
                        .onTapGesture {
                            toggleSheet = true
                        }
                }
            }
            .overlay {
                if pets.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Pets", systemImage: "pawprint")
                    }, description: {
                        Text("Tap the paw to add your first pet!")
                    }, actions: {
                        Button(action: {
                            toggleSheet = true
                        }) {
                            AddPetButton()
                        }
                        .offset(y: 100)
                    })
                    .offset(y: -100)
                }
            }
        }
    }

    private var addPetButton: some View {
        VStack {
            Spacer()
            HStack() {
                AddPetButton()
                    .frame(width: 80, height: 80)
                    .onTapGesture {
                        toggleSheet = true
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        .padding(.bottom, 110)
        .padding(.horizontal, 20)
    }

}

#Preview {
    PetsView()
}

//Array(Set(vm2.catImages)).prefix(4), id: \.id
//if let imageUrl = uniqueImage.sample_url {
//    WebImage(url: URL(string: imageUrl))
//        .resizable()
//        .indicator(.activity)
//        .scaledToFill()
//        .frame(maxWidth: 100)
//        .frame(minWidth: 0)
//        .frame(height: 120)
//        .clipShape(RoundedRectangle(cornerRadius: 10))
//        .allowsHitTesting(false)                            .overlay(
//            //Sex add later
//            Circle()
//                .frame(width: 30, height: 30)
//                .offset(x: 30, y: 40)
//                .overlay(
//                    //Image(systemName: "")
//                    Text("♀︎")
//                        .font(.title2)
//                        .bold()
//                        .foregroundStyle(Color.pink)
//                        .frame(width: 30, height: 30)
//                        .offset(x: 30, y: 40)
//                        .shadow(radius: 10, y: 5)
//                )
//        )
//    }
