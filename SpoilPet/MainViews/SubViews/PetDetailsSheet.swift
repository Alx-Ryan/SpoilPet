    //
    //  PetDetailsSheet.swift
    //  SpoilPet
    //
    //  Created by Alex Ryan on 5/26/24.
    //

import SwiftUI
import SwiftData
import PhotosUI
import SDWebImageSwiftUI


struct PetDetailsSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss

    @StateObject var photoVM = PhotoPickerVM()
   // @State private var selectedPhoto: PhotosPickerItem?

        // species vars
    @State private var speciesDropdown: Bool = false
    @State var speciesSelection = Species.other
        // sex vars
    @State private var sex = Sex.other
    @State private var sexDropdown: Bool = false
    @State private var name: String = ""
    @State private var breed: String = ""
    @State private var age: Int?
    @State private var weight: Int?

    //let pet: PetProfile

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0) {
                    
                    heroImage
                    
                    nameField

                    HStack(spacing: 8) {
                        speciesPicker
                        sexPicker
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 6)

                    BreedField

                    HStack(spacing: 8) {
                        AgeField
                        WeightField
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 6)


                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    private var heroImage: some View {
        ZStack {
            if let image = photoVM.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(minHeight: 200)
                    .frame(maxWidth: 380)
                    .frame(height: 400)
                
            } else {
                HStack(spacing: 0) {
                    ZStack {
                        Color.cell
                        VStack {
                            Text("Select Photo")
                        }
                    }
                    .scaledToFill()
                    .frame(minHeight: 200)
                    .frame(maxWidth: 380)
                    .frame(height: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .allowsHitTesting(false)
                }
               }

            xButton
                .frame(maxWidth: .infinity, maxHeight: 400, alignment: .topLeading)
                .onTapGesture {
                    dismiss()
                }

            saveButton
                .frame(maxWidth: .infinity, maxHeight: 400, alignment: .topTrailing)
                .onTapGesture {
                    let pet = PetProfile(petName: name, petPhoto: photoVM.selectedImage?.sd_imageData(), breed: breed, sex: sex, species: speciesSelection, age: age, weight: weight)
                    context.insert(pet)

                    dismiss()
                }
            
            photoButton
                .frame(maxWidth: .infinity, maxHeight: 400, alignment: .bottomTrailing)
                // Image ZStack
        }
        .frame(minHeight: 200)
        .frame(maxWidth: 380)
        .frame(height: 400)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(8)
        //.onChange(of: selectedPhoto, loadPhoto)
    }
    
    private var xButton: some View {
        Image(systemName: "xmark")
            .font(.headline)
            .bold()
            .padding(6)
            .foregroundStyle(.hero)
            .background(.white)
            .clipShape(Circle())
            .padding()
    }

    private var saveButton: some View {
        Image(systemName: "checkmark")
            .font(.headline)
            .bold()
            .padding(6)
            .foregroundStyle(.hero)
            .background(.white)
            .clipShape(Circle())
            .padding()
    }

    private var photoButton: some View {
        PhotosPicker(selection: $photoVM.imageSelection, matching: .images) { 
            Image(systemName: "pawprint.circle")
                .font(.title)
                .padding(8)
                .foregroundStyle(.accent)
                .shadow(radius: 10)
                .background(.touchPadding)
        } 
        .padding(8)
    }
    
    private var nameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Name")
                .font(.headline)
                .foregroundStyle(.accent)
            TextField(text: $name) {
                Text("Enter Name")
                    .foregroundStyle(.text.opacity(0.5))
            }
//            FloatingTextField($name, contentType: .name, placeholder: "Name", color: .accent)
//                .lineLimit(1)
//                .minimumScaleFactor(0.7)
//                .foregroundStyle(.text.opacity(0.5))
            .font(.title2)
            .bold()
            .padding(4)
            .background(Color.background.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .textContentType(.name)

        }
        .modifier(PetDetailsViewModifier())
    }
    
    private var speciesPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Species")
                .font(.headline)
                .foregroundStyle(.accent)

            Menu {
                Picker(selection: $speciesSelection) {
                    ForEach(Species.allCases) { species in
                        Text(species.name)
                            .tag(species)
                    }
                } label: {}
            } label: {
                Text(speciesSelection.name)
                
                Spacer()
                Image(systemName: "chevron.backward")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.accent)
                    .rotationEffect(.degrees(speciesDropdown ? -90 : 0))
                    .animation(.easeOut, value: speciesDropdown)
            }
            .font(.title2)
            .bold()
            .padding(4)
            .foregroundStyle(.text)
            .background(Color.background.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .id(speciesSelection)
            .onTapGesture {
                speciesDropdown.toggle()
            }
        }
        .padding()
        .background(Color.cell)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var sexPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sex")
                .font(.headline)
                .foregroundStyle(.accent)

            Menu {
                Picker(selection: $sex) {
                    ForEach(Sex.allCases) { sex in
                        Text(sex.name)
                            .tag(sex)                        
                    }
                } label: {}
            } label: {
                HStack(spacing: 4) {
                    Text(sex.name)
                    Text(sex.symbol)
                        .foregroundStyle(sex.symbolColor.gradient)
                }
                Spacer()
                Image(systemName: "chevron.backward")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(Color.accent)
                    .rotationEffect(.degrees(sexDropdown ? -90 : 0))
                    .animation(.easeOut, value: sexDropdown)
            }
            .font(.title2)
            .bold()
            .padding(4)
            .foregroundStyle(.text)
            .background(Color.background.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .id(sex)
            .onTapGesture {
                sexDropdown.toggle()
            }
        }
        .padding()
        .background(Color.cell)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var BreedField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Breed")
                .font(.headline)
                .foregroundStyle(.accent)
            TextField(text: $breed) {
                Text("Enter Breed")
                    .foregroundStyle(.text.opacity(0.5))
            }
            .font(.title2)
            .bold()
            .padding(4)
            .background(Color.background.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .lineLimit(1)
            .minimumScaleFactor(0.8)


        }
        .modifier(PetDetailsViewModifier())
    }

    private var AgeField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Age")
                .font(.headline)
                .foregroundStyle(.accent)
            TextField(value: $age, format: .number) {
                Text("Enter Age")
                    .keyboardType(.numberPad)
                    .foregroundStyle(.text.opacity(0.5))
            }
            .font(.title2)
            .bold()
            .padding(4)
            .background(Color.background.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 6))

        }
        .padding()
        .background(Color.cell)
        .clipShape(RoundedRectangle(cornerRadius: 10))

    }

    private var WeightField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Weight")
                .font(.headline)
                .foregroundStyle(.accent)
            TextField(value: $weight, format: .number) {
                Text("Enter Weight")
                    .keyboardType(.numberPad)
                    .foregroundStyle(.text.opacity(0.5))
            }
            .font(.title2)
            .bold()
            .padding(4)
            .background(Color.background.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 6))

        }
        .padding()
        .background(Color.cell)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {

 PetDetailsSheet()

}
