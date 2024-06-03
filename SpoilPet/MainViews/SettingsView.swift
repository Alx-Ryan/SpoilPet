    //
    //  SettingsView.swift
    //  SpoilPet
    //
    //  Created by Alex Ryan on 5/24/24.
    //

import SwiftUI

struct SettingsView: View {
    
    
    @AppStorage("colorScheme", store: UserDefaults(suiteName: "group.com.AlexRyan.SpoilPet"))
    var colorScheme: Int = 0
    var colorSchemeString: String {
        if colorScheme == 1 {
            return String(localized: "Light")
        } else if colorScheme == 2 {
            return String(localized: "Dark")
        } else {
            return String(localized: "System")
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 8) {
                        Spacer(minLength: 8)
                        Text("GENERAL")
                            .font(.system(.footnote, design: .rounded).weight(.semibold))
                            .foregroundColor(Color.text)
                            .padding(.horizontal, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 13) {
                            NavigationLink(destination: SettingsAppearanceView()) {
                                SettingsRowView(
                                    systemImage: "circle.righthalf.filled", title: "Appearance", color: "AppearanceIcon",
                                    optionalText: colorSchemeString)
                            }
                        }
                        .padding(10)
                        .background(Color.cell, in: RoundedRectangle(cornerRadius: 10))
                        
                    }
                }
                .padding(.horizontal)

            }
            .navigationTitle("Settings")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.hero, for: .navigationBar)
        }
    }
}

#Preview {
    SettingsView()
}

struct SettingsRowView: View {
    var systemImage: String
    var title: String
    var color: String
    var optionalText: String?
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.white)
                .frame(
                    width: dynamicTypeSize > .xLarge ? 40 : 30, height: dynamicTypeSize > .xLarge ? 40 : 30,
                    alignment: .center
                )
                .background(Color("\(color)"), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
            
            Text(LocalizedStringKey(title))
                .font(.system(.body, design: .rounded).weight(.medium))
                .lineLimit(1)
                .foregroundColor(Color.text)
            
            Spacer()
            
            if optionalText != nil {
                Text(optionalText!)
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.hero)
                    .layoutPriority(1)
                    .padding(.trailing, -8)
            }
            
            Image(systemName: "chevron.forward")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.hero)
        }
        .frame(maxWidth: .infinity)
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
}
