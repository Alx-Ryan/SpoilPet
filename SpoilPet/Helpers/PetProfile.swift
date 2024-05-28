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
   // var petPhoto: Image? = nil
    var breed = ""
    var age: Int? = nil
    var weight: Int? = nil
    
    init(petName: String = "", /*petPhoto: Image? = nil,*/ breed: String = "", age: Int? = nil, weight: Int? = nil) {
        self.petName = petName
       // self.petPhoto = petPhoto
        self.breed = breed
        self.age = age
        self.weight = weight
    }
    
}
