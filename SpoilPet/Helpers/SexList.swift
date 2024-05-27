//
//  SexList.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/27/24.
//

import SwiftUI

enum Sex: Hashable, CaseIterable, Identifiable {
    case male, female, other
    
    var id: Self { self }
    
    var name: String {
        switch self {
            case .male:
                return "Male"
            case .female:
                return "Female"
            case .other:
                return "Other"
        }
    }
    
    var symbol: String {
        switch self {
            case .male:
                return "♂️"
            case .female:
                return "♀️"
            case .other:
                return " ?"
        }
    }
    
    var symbolColor: Color {
        switch self {
            case .male:
                return .blue
            case .female:
                return .pink
            case .other:
                return .purple
        }
    }
}
