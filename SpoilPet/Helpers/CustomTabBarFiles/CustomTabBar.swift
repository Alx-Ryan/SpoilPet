//
//  CustomTabBar.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/22/24.
//

import SwiftUI

struct CustomTabBar: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    
    var body: some View {
        tabBarV2
    }
}

#Preview {

    ZStack {
        Color.background.ignoresSafeArea()
        
        VStack {
            Spacer()
            
//            let tabs: [TabBarItem] = [
//                    TabBarItem(
//                        iconName: "calendar",
//                        title: "Schedule",
//                        SelectedColor: Color.secondaryText
//                    ),
//                    TabBarItem(
//                        iconName: "pawprint",
//                        title: "Pets",
//                        SelectedColor: Color.highlight
//                    ),
//                    TabBarItem(
//                        iconName: "gear",
//                        title: "Settings",
//                        SelectedColor: Color.accent
//                    )
//                ]
            
//            CustomTabBar(tabs: tabs, selection: .constant(tabs.last!))
 let tabs: [TabBarItem] = [.schedule, .pets, .settings]
            CustomTabBar(tabs: tabs, selection: .constant(.pets))
            //.padding()
        }
    }
}


extension CustomTabBar {
    
    private var tabBarV1: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding()
    }
    
    private var tabBarV2: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.background.ignoresSafeArea(edges: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.3), radius: 10)
        .padding(.horizontal)
    }

    
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundStyle(selection == tab ? tab.SelectedColor : Color.secondaryText)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        //.background(selection == tab ? tab.SelectedColor.opacity(0.15) : Color.clear)
        .background(
            ZStack {
                if selection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.SelectedColor.opacity(0.15))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
        //.clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func switchToTab(tab: TabBarItem) {
        withAnimation(.easeInOut) { 
            selection = tab
        }
    }
}


