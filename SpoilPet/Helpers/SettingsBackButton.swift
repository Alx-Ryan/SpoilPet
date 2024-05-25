//
//  SettingsBackButton.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/24/24.
//

import SwiftUI

struct SettingsBackButton: View {
    var body: some View {
        Image(systemName: "chevron.left")
            .font(.system(.subheadline, design: .rounded).weight(.semibold))
            .foregroundColor(Color.text)
            .padding(8)
            .background(Color.background, in: Circle())
    }
}
