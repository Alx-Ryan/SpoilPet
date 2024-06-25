//
//  MealCell.swift
//  SpoilPet
//
//  Created by Alex Ryan on 6/24/24.
//

import SwiftUI
//import SwiftData

struct MealCell: View {

    let meal: MealPlan

    var body: some View {

            ZStack {
                HStack(spacing: 0) {
                    VStack {
                        if let image = UIImage(data: meal.foodPhoto ?? Data()) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 100)
                                .frame(height: 100)
                                .scaledToFill()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        } else {
                            Text("No Image Selected")
                                .foregroundColor(.secondary)
                                .font(.system(size: 20))
                                .lineLimit(2)
                                .minimumScaleFactor(0.8)
                                .padding(4)
                        }
                    }
                    .frame(maxWidth: 80)
                    .frame(height: 80)
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                    VStack(spacing: 4) {
                        Text(!meal.foodName.isEmpty ? meal.foodName : "Enter a food")
                            .bold()
                            .underline()
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                            .padding(.bottom, 4)
                        Text(!meal.portion.isEmpty ? meal.portion + " " + meal.unitSelection : "0" + " " + meal.unitSelection)
                            .minimumScaleFactor(0.8)
                    }
                    .padding(4)
                    .padding(.leading)
                    .padding(.top, 4)

                    VStack(spacing: 4) {
                        Text("Schedule")
                            .bold()
                            .underline()
                            .minimumScaleFactor(0.8)
                            .padding(.bottom, 4)
                        if let mealTime = meal.mealTime {
                            Text("\(mealTime.formatted(date: .omitted, time: .shortened))")
                                .minimumScaleFactor(0.8)
                        } else {
                            Text("No schedule")
                                .minimumScaleFactor(0.8)
                        }
                    }
                    .padding()

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 80)
                .background(.cell)
                .clipShape(.rect(cornerRadius: 20))
            }
            .foregroundStyle(.accent)
        }
    
}

#Preview {
    MealCell(meal: MealPlan(unitSelection: "Cups", portion: "1 1/3", foodName: "Chicken Nuggets", mealTime: nil, foodPhoto: nil))
        .padding()

}
