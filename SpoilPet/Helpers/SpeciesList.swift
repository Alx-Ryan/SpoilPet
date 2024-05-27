//
//  SpeciesList.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/27/24.
//

import SwiftUI

enum species: Hashable, CaseIterable, Identifiable {
    case cat, dog, fish, bird, turtle, hamster, rabbit, guineaPig, snake, lizard, frog, gerbil, rat, mouse, hedgehog
    
    var id: Self {self}
    
    var name: String {
        switch self {
            case .cat:
                return "Cat"
            case .dog:
                return "Dog"
            case .fish:
                return "Fish"
            case .bird:
                return "Bird"
            case .turtle:
                return "Turtle"
            case .hamster:
                return "Hamster"
            case .rabbit:
                return "Rabbit"
            case .guineaPig:
                return "Guinea Pig"
            case .snake:
                return "Snake"
            case .lizard:
                return "Lizard"
            case .frog:
                return "Frog"
            case .gerbil:
                return "Gerbil"
            case .rat:
                return "Rat"
            case .mouse:
                return "Mouse"
            case .hedgehog:
                return "Hedgehog"
        }
    }
}
