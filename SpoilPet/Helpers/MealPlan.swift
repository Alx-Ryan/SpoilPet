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

    var unitSelection: String = "C"
    var portion: String = ""
    var foodName: String = ""
    var mealTime: Date? = nil

    init(unitSelection: String, portion: String, foodName: String, mealTime: Date? = nil) {
        self.unitSelection = unitSelection
        self.portion = portion
        self.foodName = foodName
        self.mealTime = mealTime
    }

}
