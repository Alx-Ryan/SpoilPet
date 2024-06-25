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

    @State var unitSelection: String = "Cups"
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

                            // Meal Preview
                        Text("Meal Preview")
                            .font(.headline)
                            .foregroundStyle(.accent)
                            .padding(.top)
                            mealPreview

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

    private var mealPreview: some View {
        ZStack {
            HStack {
                VStack {
                    if let image = photoVM.selectedImage {
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
                .frame(maxWidth: 100)
                .frame(height: 100)
                .background()
                .clipShape(RoundedRectangle(cornerRadius: 20))

                VStack {
                    Text(!foodName.isEmpty ? foodName : "Enter a food")
                        .bold()
                        .underline()
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .padding(.bottom, 4)
                    Text(!portion.isEmpty ? portion + " " + unitSelection : "0" + " " + unitSelection)
                }
                .padding()

                Spacer()

                VStack {
                    Text("Schedule")
                        .bold()
                        .underline()
                        .padding(.bottom, 4)
                    Text("\(mealtime.formatted(date: .omitted, time: .shortened))")
                }
                .padding()

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 100)
            .background(.cell)
            .clipShape(.rect(cornerRadius: 20))
        }
        .foregroundStyle(.accent)
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
                        Text("Cans").tag("Cans")
                        Text("Packets").tag("Packets")
                        Text("Pieces").tag("Pieces")
                        Text("Tablets").tag("Tablets")
                        Text("tsp").tag("tsp")
                        Text("tbsp").tag("tbsp")
                        Text("Cups").tag("Cups")
                        Text("Grams").tag("Grams")
                        Text("Ounces").tag("Ounces")
                        Text("Pints").tag("Pints")
                        Text("Liters").tag("Liters")
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
