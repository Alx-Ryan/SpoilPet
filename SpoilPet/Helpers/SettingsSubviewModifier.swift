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
