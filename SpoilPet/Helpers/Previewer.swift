//
//  Previewer.swift
//  SpoilPet
//
//  Created by Alex Ryan on 6/1/24.
//

import SwiftUI
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let pet: PetProfile
    let pet2: PetProfile
    let pet3: PetProfile

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: PetProfile.self, configurations: config)

        pet = PetProfile(petName: "Sally", petPhoto: nil, breed: "Beagle", sex: Sex.female, species: Species.dog, age: 12, weight: 23)
        pet2 = PetProfile(petName: "Usagi", petPhoto: nil, breed: "Pom", sex: Sex.male, species: Species.dog, age: 8, weight: 14)
        pet3 = PetProfile(petName: "Tom", petPhoto: nil, breed: "Cheeta", sex: Sex.other, species: Species.cat, age: 8, weight: 14)

        container.mainContext.insert(pet)
        container.mainContext.insert(pet2)
        container.mainContext.insert(pet3)

    }

}


let previewContainer: ModelContainer = {
    do {
            // Create the configuration
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)

            // Initialize the container with the configuration
        let container = try ModelContainer(for: PetProfile.self, configurations: configuration)

        Task { @MainActor in
            let context = container.mainContext

            let petExample = PetProfile.example()
            context.insert(petExample)

                // Save the context if needed
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error.localizedDescription)")
            }
        }
        return container
    } catch {
        fatalError("Failed to create container with error: \(error.localizedDescription)")
    }
}()
