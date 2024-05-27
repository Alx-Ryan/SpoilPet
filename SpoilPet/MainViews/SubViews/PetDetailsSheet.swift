    //
    //  PetDetailsSheet.swift
    //  SpoilPet
    //
    //  Created by Alex Ryan on 5/26/24.
    //

import SwiftUI
import PhotosUI
import SDWebImageSwiftUI

@MainActor
final class PhotoPickerVM: ObservableObject {
    
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                guard let data, let uiImage = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                selectedImage = uiImage
            } catch {
                print(error)
            }
        }
    }
}

struct PetDetailsSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var vm = CombineVM()
    @StateObject var photoVM = PhotoPickerVM()
    
    @State var name = ""
    @State var breed = ""
    
    // species vars
    @State private var speciesDropdown: Bool = false
    @State var speciesSelection = species.dog
    // sex vars
    @State private var sex = Sex.other
    @State private var sexDropdown: Bool = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0) {
                    
                    heroImage
                    
                    nameField
                    
                    speciesPicker
                    
                    sexPicker
                    
                    BreedField
                    
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
                
            } else if let firstImageUrl = vm.catImages.first?.sample_url, !firstImageUrl.isEmpty {
                WebImage(url: URL(string: /*firstImageUrl*/ Constants.randomImage))
                    .resizable()
                    .indicator(.activity)
                    .offset(y: 50)
                    .scaledToFill()
            } else {
                ProgressView()
                    .frame(maxWidth: 380)
            }
            xButton
                .frame(maxWidth: .infinity, maxHeight: 400, alignment: .topLeading)
                .onTapGesture {
                    dismiss.callAsFunction()
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
    }
    
    private var xButton: some View {
        Image(systemName: "xmark")
            .font(.headline)
            .bold()
            .padding(6)
            .foregroundStyle(.accent)
            .background(.white)
            .clipShape(Circle())
            .padding()
    }
    
    private var photoButton: some View {
        PhotosPicker(selection: $photoVM.imageSelection, matching: .images) { 
            Image(systemName: "photo")
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
                .foregroundStyle(.highlight)
            TextField(text: $name) { 
                Text("Enter Name")
                    .foregroundStyle(.text.opacity(0.5))
            }
            .font(.title)
            .bold()
            .padding(4)
            .background(Color.background.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
        }
        .modifier(PetDetailsViewModifier())
    }
    
    private var speciesPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Species")
                .font(.headline)
                .foregroundStyle(.highlight)
            
            Menu {
                Picker(selection: $speciesSelection) {
                    ForEach(species.allCases) { species in
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
                    .foregroundStyle(.highlight)
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
        .modifier(PetDetailsViewModifier())
    }
    
    private var sexPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sex")
                .font(.headline)
                .foregroundStyle(.highlight)
            
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
                    .foregroundStyle(.highlight)
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
        .modifier(PetDetailsViewModifier())
    }
    
    private var BreedField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Breed")
                .font(.headline)
                .foregroundStyle(.highlight)
            TextField(text: $breed) { 
                Text("Enter Breed")
                    .foregroundStyle(.text.opacity(0.5))
            }
            .font(.title2)
            .bold()
            .padding(4)
            .background(Color.background.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
        }
        .modifier(PetDetailsViewModifier())
    }
    
}

#Preview {
    PetDetailsSheet()
}
