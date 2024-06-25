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
    var meal: [MealPlan]?

    init(petName: String = "", petPhoto: Data? = nil, breed: String = "", sex: Sex? = nil, species: Species? = nil, age: Int? = nil, weight: Int? = nil) {
        self.petName = petName
        self.petPhoto = petPhoto
        self.breed = breed
        self.sex = sex
        self.species = species
        self.age = age
        self.weight = weight
    }

    static func example() -> PetProfile {
        let petProfile = PetProfile(petName: "Sally", petPhoto: nil, breed: "Beagle", sex: Sex.female, species: Species.dog, age: 12, weight: 23)
        let meal1 = MealPlan(unitSelection: "Cups", portion: "1", foodName: "Chicken Nuggets", mealTime: nil, foodPhoto: nil)
        //let meal2 = MealPlan(unitSelection: "Cups", portion: "1", foodName: "Fish", mealTime: nil, foodPhoto: nil)
        petProfile.meal = [meal1]
        //petProfile.meal?.append(meal2)
        return petProfile

    }

}
