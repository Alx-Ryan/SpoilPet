    //
    //  WaterPetReminderView.swift
    //  SpoilPet
    //
    //  Created by Alex Ryan on 5/28/24.
    //

import SwiftUI

struct WaterPetReminderView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(stops: [
                    .init(color: Color(hex: "#209cff"), location: 0),
                    .init(color: Color(hex: "#68e0cf"), location: 1),
                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: .infinity, height: 80)
                .shadow(radius: 3)
            
            Text("Don't forget to refill water bowl 🚰")
                .font(.title3)
                .bold()
                .foregroundStyle(.text)
        }
    }
}

#Preview {
    WaterPetReminderView()
}


