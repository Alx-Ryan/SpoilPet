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

    @State var unitSelection: String = "C"
    @State var portion: String = ""
    @State var foodName: String = ""
    @State var mealtime: Date = Date()

    @StateObject var photoVM = PhotoPickerVM()

    var body: some View {
        ZStack{
            ScrollView {

                    //MARK: List Option
                VStack(spacing: 20) {
                        // Food Name
                    foodNameCell

                        // Portion info
                    portionSize

                        // Schedule
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
                                Text("3/4 Cup")
                            }
                            .padding(12)
                        }

                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.cell)
                    .clipShape(.rect(cornerRadius: 15))
                }

            }
        }
        .toolbar {
            Button("Accept") {
                let meal = MealPlan(unitSelection: unitSelection, portion: portion, foodName: foodName, mealTime: mealtime)
                context.insert(meal)

               // dismiss()
            }
        }
        .tint(.accent)


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
                FloatingTextField($foodName, placeholder: "Name of Food")
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
            FloatingTextField($portion, contentType: .number, placeholder: "Enter Amount")
                .padding()
                .padding(.bottom, 4)

            HStack(spacing: 0) {

                Picker(selection: $unitSelection) {
                    Text("Can").tag("Can")
                    Text("Packet(s)").tag("Packet")
                    Text("Piece(s)").tag("Piece")
                    Text("Tablet(s)").tag("Tablet")
                    Text("tsp").tag("tsp")
                    Text("tbsp").tag("tbsp")
                    Text("Cups").tag("C")
                    Text("Grams").tag("g")
                    Text("Ounce").tag("Oz")
                    Text("Pint").tag("Pt")
                    Text("Liter").tag("L")
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
