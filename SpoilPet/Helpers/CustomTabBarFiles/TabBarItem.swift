//
//  TabBarItem.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/22/24.
//

import SwiftUI

//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let SelectedColor: Color
//}

enum TabBarItem: Hashable {
    case schedule, pets, settings
    
    var iconName: String {
        switch self {
            case .schedule: return "calendar.badge.clock"
            case .pets: return "pawprint"
            case .settings: return "gear"
        }
    }
    
    var title: String {
        switch self {
            case .schedule: return "Schedule"
            case .pets: return "Pets"
            case .settings: return "Settings"
        }
    }
    
    var SelectedColor: Color {
        switch self {
            case .schedule: return Color.accent
            case .pets: return Color.accent
            case .settings: return Color.accent
        }
    }
    
}
