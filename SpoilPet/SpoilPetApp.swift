//
//  SpoilPetApp.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/3/24.
//

import SwiftUI
import SwiftData

@main
struct SpoilPetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: PetProfile.self)
    }
}
