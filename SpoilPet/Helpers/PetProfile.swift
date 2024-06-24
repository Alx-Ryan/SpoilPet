//
//  PetProfile.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/3/24.
//

import SwiftUI
import SwiftData

@Model
final class PetProfile {

    var petName = ""
    @Attribute(.externalStorage) var petPhoto: Data?
    var breed = ""
    var sex: Sex? = nil
    var species: Species? = nil
    var age: Int? = nil
    var weight: Int? = nil
    var meal: [MealPlan]? = nil

    init(petName: String = "", petPhoto: Data? = nil, breed: String = "", sex: Sex? = nil, species: Species? = nil, age: Int? = nil, weight: Int? = nil) {
        self.petName = petName
        self.petPhoto = petPhoto
        self.breed = breed
        self.sex = sex
        self.species = species
        self.age = age
        self.weight = weight
    }

}
