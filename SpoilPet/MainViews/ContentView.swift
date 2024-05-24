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
            Color.red
                .tabBarItem(tab: .settings, selection: $tabSelection)
            
        }
        .background(Color.background)
    }
}

#Preview {
    return ContentView()
}
