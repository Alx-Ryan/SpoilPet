//
//  ColorEXT.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/3/24.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    public static var touchPadding: Color { return Color(.black.opacity(0.001)) }
    
    var linearGradient: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [self]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    public static func gay(start: UnitPoint, end: UnitPoint) -> some View {
        LinearGradient(stops: [
            .init(color: Color.blue, location: 0),
            .init(color: Color.pink, location: 1),
        ], startPoint: start, endPoint: end)
    }
}

extension Color {
//    public static var PrimaryText: Color { return Color("Text") }
//    
//    public static var Icon: Color { return Color("SecondaryText") }
    
    
//        static func gradient(_ color1: Color, _ color2: Color) -> Color {
//            Color.gradient(colors: [color1, color2])
//        }
//        
//        static func gradient(colors: [Color]) -> Color {
//            Color.linearGradient(colors: colors, startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
//        }
    
}
