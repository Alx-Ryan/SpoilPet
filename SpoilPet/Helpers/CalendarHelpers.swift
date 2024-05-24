//
//  CalendarHelpers.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/23/24.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
