    //
    //  ContentView.swift
    //  SpoilPet
    //
    //  Created by Alex Ryan on 5/3/24.
    //

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State private var tabSelection: TabBarItem = .schedule
    
    @AppStorage("colorScheme", store: UserDefaults(suiteName: "group.com.AlexRyan.SpoilPet")) var colorScheme: Int = 0
    
        // @Query var pets: [PetProfile]
    
    var resizingMode: ContentMode = .fill
    
    var body: some View {
        CustomTabBarContainer(selection: $tabSelection) {
            
                //MARK: First tab item
            ScheduleView()
                .tabBarItem(tab: .schedule, selection: $tabSelection)
            
                //MARK: Second tab item
            PetsView()
                .tabBarItem(tab: .pets, selection: $tabSelection)
            
                //MARK: Third tab item
            SettingsView()
                .tabBarItem(tab: .settings, selection: $tabSelection)
            
        }
        .background(Color.background)
        .preferredColorScheme(colorScheme == 1 ? .light : colorScheme == 2 ? .dark : nil)
    }
}

#Preview {
    return ContentView()
}
