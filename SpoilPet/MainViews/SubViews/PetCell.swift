    //
    //  PetCell.swift
    //  SpoilPet
    //
    //  Created by Alex Ryan on 5/31/24.
    //

import SwiftUI
import SDWebImageSwiftUI

struct PetCell: View {

    let pet: PetProfile

    var body: some View {

        ZStack {
            HStack(alignment: .top, spacing: 12) {
                if let image = UIImage(data: pet.petPhoto ?? Data()) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 100)
                        .frame(minWidth: 0)
                        .frame(height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .allowsHitTesting(false)
                        .overlay(
                            Circle()
                                .fill(Color.white)
                                .frame(width: 25, height: 25)
                                .offset(x: 30, y: 40)
                                .overlay(
                                    Text(pet.sex?.symbol ?? Sex.other.symbol)
                                        .font(.title3)
                                        .bold()
                                        .foregroundStyle(pet.sex?.symbolColor ?? Sex.other.symbolColor)
                                        .frame(width: 30, height: 30)
                                        .offset(x: pet.sex?.symbol == Sex.other.symbol ? 30 : 31,
                                                y: pet.sex?.symbol == Sex.other.symbol ? 39 : 38)
                                        .shadow(radius: 10, y: 5)
                                )
                        )

                } else {
                    HStack(spacing: 0) {
                        ZStack {
                            Color.cell
                            VStack {
                                Text("Select Photo")
                                Image(systemName: "pawprint.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                            }
                        }
                        .scaledToFill()
                        .frame(maxWidth: 100)
                        .frame(minWidth: 0)
                        .frame(height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .allowsHitTesting(false)
                    }
                }
                
                    // pet details
                VStack(alignment: .leading, spacing: 4) {
                        // Pet name and Breed
                    HStack {
                        Text(pet.petName)
                            .font(.title3)
                            .bold()
                            .minimumScaleFactor(0.8)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        VStack(spacing: 0) {
                            Text(pet.species?.name ?? "?")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.text.opacity(0.9))
                                .padding(.horizontal, 12)

                            Text(pet.breed)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.text.opacity(0.9))
                                .padding(.horizontal, 12)

                        }
                        .padding(.horizontal, 8)
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                        // Age
                    HStack {
                        Image(systemName: "calendar")
                        if pet.age == nil {
                            Text("?")
                        } else {
                            Text("\(pet.age ?? 0)")
                        }
                    }
                    .font(.footnote)
                    .padding(4)
                    .background(RoundedRectangle(cornerRadius: 4).fill(Color.hero))
                        // Weight
                    HStack {
                        Image(systemName: "scalemass")
                        if pet.weight == nil {
                            Text("?")
                        } else {
                            Text("\(pet.weight ?? 0)")
                        }
                    }
                    .font(.footnote)
                    .padding(4)
                    .background(RoundedRectangle(cornerRadius: 4).fill(Color.hero))
                }
            }
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.cell))
        }
    }
}

#Preview {
    VStack {
        PetCell(pet: PetProfile(petName: "Bella", petPhoto: nil, breed: "Cobra", sex: .female, species: .snake, age: 3, weight: 10))
        PetCell(pet: PetProfile(petName: "Sally", petPhoto: nil, breed: "Beagle", sex: Sex.female, species: Species.dog, age: 12, weight: 23))
        PetCell(pet: PetProfile(petName: "Max", petPhoto: nil, breed: "Bobcat", sex: Sex.male, species: Species.cat, age: 5, weight: 15))
    }

}
