//
//  SettingsSubviewModifier.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/24/24.
//

import SwiftUI

struct SettingsSubviewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.background)
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
}

struct PetDetailsViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.cell)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            .padding(.vertical, 6)
    }
}

struct PetCellImageModifier: ViewModifier {
    var sexSymbol: String
    var sexColor: Color
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(maxWidth: 100)
            .frame(minWidth: 0)
            .frame(height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .allowsHitTesting(false)
            .overlay(
                Circle()
                    .fill(Color.white)
                    .frame(width: 30, height: 30)
                    .offset(x: 30, y: 40)
                    .overlay(
                        Text(sexSymbol)
                            .font(.title2)
                            .bold()
                            .foregroundStyle(sexColor)
                            .frame(width: 30, height: 30)
                            .offset(x: 30, y: 40)
                            .shadow(radius: 10, y: 5)
                    )
            )
    }
}


    
