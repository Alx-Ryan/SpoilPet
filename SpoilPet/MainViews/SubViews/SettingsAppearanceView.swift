    //
    //  SettingsAppearanceView.swift
    //  SpoilPet
    //
    //  Created by Alex Ryan on 5/24/24.
    //

import SwiftUI

struct SettingsAppearanceView: View {
    @AppStorage("colorScheme", store: UserDefaults(suiteName: "group.com.AlexRyan.SpoilPet"))
    var colorScheme: Int = 0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let options = ["System", "Light", "Dark"]
    
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Appearance")
                .font(.system(.title3, design: .rounded).weight(.semibold))
                .foregroundColor(Color.text)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        SettingsBackButton()
                    }
                }
                .padding(.bottom, 20)
            
            VStack(spacing: 0) {
                ForEach(options.indices, id: \.self) { option in
                    HStack {
                        Text(LocalizedStringKey(options[option]))
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(Color.text)
                        
                        Spacer()
                        
                        if colorScheme == option {
                            Image(systemName: "checkmark")
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundColor(Color.accent.opacity(0.6))
                                .matchedGeometryEffect(id: "tick", in: animation)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.15)) {
                            colorScheme = option
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .padding(.vertical, 9)
                    .overlay(alignment: .bottom) {
                        if option < (options.count - 1) {
                            Divider()
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
            .background(Color.cell, in: RoundedRectangle(cornerRadius: 9))
            .shadow(radius: 10)
        }
        .modifier(SettingsSubviewModifier())
    }
}


#Preview {
    SettingsAppearanceView()
}
