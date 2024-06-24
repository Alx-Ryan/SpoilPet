    //
    //  FoodView.swift
    //  SpoilPet
    //
    //  Created by Alex Ryan on 6/3/24.
    //

import SwiftUI
import SwiftData
import PhotosUI

struct AddFoodView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss

    @State var unitSelection: String = "Cup"
    @State var portion: String = ""
    @State var foodName: String = ""
    @State var mealtime: Date = Date()

    @StateObject var photoVM = PhotoPickerVM()

    var body: some View {
        NavigationStack {
            ZStack{
                    ScrollView {

                                // Food Name
                            foodNameCell

                                // Portion info
                            portionSize

                                // Schedule
                            schedule

                    }
                }
                .toolbar {
                    Button("Accept") {
                        let meal = MealPlan(unitSelection: unitSelection, portion: portion, foodName: foodName, mealTime: mealtime)
                        context.insert(meal)

                       dismiss()
                    }
                }
            .tint(.accent)
        }
    }

    private var foodNameCell: some View {
        HStack(spacing: 8) {
            ZStack {
                if let image = photoVM.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 100)
                        .frame(height: 100)
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 20))

                } else {
                    ZStack {
                        Color.cell
                        VStack {
                            Text("Select Photo")
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                        }
                        .frame(width: 80)
                    }
                    .scaledToFill()
                    .frame(maxWidth: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .allowsHitTesting(false)
                    photoButton
                        .offset(y: 30)
                }
            }
            VStack(alignment: .leading) {
                FloatingTextField($foodName, contentType: .none, placeholder: "Name of Food", color: .accent)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(.cell)
        .clipShape(.rect(cornerRadius: 15))
    }

    private var portionSize: some View {
        HStack {
            FloatingTextField($portion, contentType: .number, placeholder: "Enter Amount", color: .accent)
                .padding()
                .padding(.bottom, 4)

            HStack(spacing: 0) {

                Picker(selection: $unitSelection) {
                    Group {
                        Text("Can").tag("Can")
                        Text("Packet").tag("Packet")
                        Text("Piece").tag("Piece")
                        Text("Tablet").tag("Tablet")
                        Text("tsp").tag("tsp")
                        Text("tbsp").tag("tbsp")
                        Text("Cup").tag("Cup")
                        Text("Gram").tag("Gram")
                        Text("Ounce").tag("Ounce")
                        Text("Pint").tag("Pint")
                        Text("Liter").tag("Liter")
                    }
                    .foregroundStyle(.accent)
                } label: {
                    Text("Units")
                }

                .frame(width: 110)
                .pickerStyle(WheelPickerStyle())
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(.cell)
        .clipShape(.rect(cornerRadius: 15))
    }

    private var schedule: some View {
        HStack(alignment: .top) {
            VStack(spacing: 0) {
                HStack {
                    Text("Schedule")
                    Spacer()
                    Text("+ Add Meal")
                        .foregroundStyle(.accent)
                }
                .padding(12)
                Divider()
                HStack {
                    DatePicker("", selection: $mealtime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                        .labelsHidden()

                    Spacer()
                    VStack {
                        Text(foodName)
                            .lineLimit(2)
                            .minimumScaleFactor(0.7)
                        Divider().frame(width: 50)
                        Text(portion + "  " + unitSelection)
                    }
                }
                .foregroundStyle(.accent)
                .padding(12)
            }

        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.cell)
        .clipShape(.rect(cornerRadius: 15))
    }

    private var photoButton: some View {
        PhotosPicker(selection: $photoVM.imageSelection, matching: .images) {
            Image(systemName: "bag")
                .font(.title)
                .padding(8)
                .foregroundStyle(.hero)
                .shadow(radius: 10)
                .background(.touchPadding)
        }
        .padding(8)
    }

}

#Preview {
    NavigationStack {
        AddFoodView()
            .padding()
    }
}
