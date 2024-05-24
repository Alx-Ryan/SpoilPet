//
//  PetProfile.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/3/24.
//

import SwiftUI

struct PetProfile: View {
    @State private var petName = ""
    @State private var petPhoto: Image? = nil
    @State private var breed = ""
    @State private var age = ""
    @State private var weight = ""
    @State private var dietaryNeeds = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                    // Header
                HStack {
                    if let petPhoto = petPhoto {
                        petPhoto
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    } else {
                        Image("default_pet_photo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    }
                    Text(petName)
                        .font(.title)
                        .padding(.leading, 10)
                }
                    // Pet Information
                Group {
                    Text("Breed: \(breed)")
                    Text("Age: \(age)")
                    Text("Weight: \(weight)")
                    Text("Dietary Needs: \(dietaryNeeds)")
                }
                .padding(.leading, 20)
                    // Edit Button
                Button(action: {
                        // Edit pet profile action
                }) {
                    Text("Edit")
                        .font(.body)
                        .padding(.leading, 20)
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
        }
    }
}

//struct PetProfileScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PetProfile()
//    }
//}
#Preview {
    PetProfile()
}
