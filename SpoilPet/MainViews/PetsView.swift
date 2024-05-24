//
//  PetsView.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/24/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct PetsView: View {
    
    @StateObject var vm2 = CombineVM()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                List {
                    ForEach(Array(Set(vm2.catImages)).prefix(4), id: \.id) { uniqueImage in
                        Section {
                            HStack(alignment: .top, spacing: 12) {
                                if let imageUrl = uniqueImage.sample_url {
                                    WebImage(url: URL(string: imageUrl))
                                        .resizable()
                                        .indicator(.activity)
                                        .scaledToFill()
                                        .frame(maxWidth: 100)
                                        .frame(minWidth: 0)
                                        .frame(height: 120)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .allowsHitTesting(false)                            .overlay(
                                            //Sex add later
                                            Circle()
                                                .frame(width: 30, height: 30)
                                                .offset(x: 30, y: 40)
                                                .shadow(radius: 10, y: 5)
                                                .overlay(
                                                    Image(systemName: "")
                                                )
                                        )
                                    
                                }
                                
                                    // pet details
                                VStack(alignment: .leading, spacing: 4) {
                                        // Pet name and Breed
                                    HStack {
                                        Text("Name")
                                            .font(.title3)
                                            .bold()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Text("Breed")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color.text.opacity(0.9))
                                            .padding(.horizontal, 12)
                                    }
                                    .padding(.top, 12)
                                    .padding(.bottom, 12)
                                    
                                        // Age
                                    HStack {
                                        Image(systemName: "calendar")
                                        Text("Age")
                                    }
                                    .font(.footnote)
                                    .padding(4)
                                    .background(RoundedRectangle(cornerRadius: 4).fill(Color.mutedGreen))
                                    
                                        // Weight
                                    HStack {
                                        Image(systemName: "scalemass")
                                        Text("Weight")
                                    }
                                    .font(.footnote)
                                    .padding(4)
                                    .background(RoundedRectangle(cornerRadius: 4).fill(Color.mutedGreen))
                                    
                                }
                            }
                            
                        }
                        
                    }
                    .listRowBackground(Color.cell)
                    .listRowInsets(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                    
                    
                }
                .shadow(radius: 5, x: 0, y: 4)
                .scrollContentBackground(.hidden)
                .foregroundStyle(Color.text)
                .navigationTitle("My Pets")
            }
        }
        .overlay(addPetButton)
    }
    
    private var addPetButton: some View {
        VStack {
            Spacer()
            HStack() {
                AddPetButton()
                    .frame(width: 80, height: 80)
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
