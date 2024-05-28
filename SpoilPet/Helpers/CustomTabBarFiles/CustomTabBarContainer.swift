//
//  CustomTabBarContainer.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/22/24.
//

import SwiftUI

struct CustomTabBarContainer<Content:View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
                
                CustomTabBar(tabs: tabs, selection: $selection)
                    .padding(.top, 12)
                    .background(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 10,
                            topTrailingRadius: 10
                        ).fill(.thinMaterial).ignoresSafeArea()
                    )

        }
        
//        VStack(spacing: 0) {
//            ZStack {
//                content
//            }
//            CustomTabBar(tabs: tabs, selection: $selection)
//        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

#Preview {
    
    let tabs: [TabBarItem] = [.schedule, .pets, .settings]
    return CustomTabBarContainer(selection: .constant(tabs.first!)) { 
        Color.red
    }
//    let tabs: [TabBarItem] = [
//        TabBarItem(
//            iconName: "calendar",
//            title: "Schedule",
//            SelectedColor: Color.spoilPetSecondary
//        ),
//        TabBarItem(
//            iconName: "pawprint",
//            title: "Pets",
//            SelectedColor: Color.highlight
//        ),
//        TabBarItem(
//            iconName: "gear",
//            title: "Settings",
//            SelectedColor: Color.spoilPetSecondary
//        )
//    ]
//
//    return 
//        
//        CustomTabBarContainer(selection: .constant(tabs.first!)) {
//            Color.red
//        }
//    
}

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 10))
            path.addLine(to: CGPoint(x: rect.width, y: 10))
            path.addArc(tangent1End: CGPoint(x: rect.width, y: 0), tangent2End: CGPoint(x: rect.width - 10, y: 0), radius: 10)
            path.addLine(to: CGPoint(x: rect.width - 10, y: rect.height))
            path.addLine(to: CGPoint(x: 10, y: rect.height))
            path.addArc(tangent1End: CGPoint(x: 0, y: rect.height), tangent2End: CGPoint(x: 0, y: rect.height - 10), radius: 10)
        }
    }
}
