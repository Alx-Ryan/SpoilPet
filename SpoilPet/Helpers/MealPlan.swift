//
//  MealPlan.swift
//  SpoilPet
//
//  Created by Alex Ryan on 6/4/24.
//

import SwiftUI
import SwiftData

@Model
final class MealPlan {

    var unitSelection: String = "Cups"
    var portion: String = ""
    var foodName: String = ""
    var mealTime: Date? = nil
    var foodPhoto: Data?

    init(unitSelection: String, portion: String, foodName: String, mealTime: Date? = nil, foodPhoto: Data? = nil) {
        self.unitSelection = unitSelection
        self.portion = portion
        self.foodName = foodName
        self.mealTime = mealTime
        self.foodPhoto = foodPhoto
    }

}
