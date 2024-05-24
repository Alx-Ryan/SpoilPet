//
//  DateEXT.swift
//  SpoilPet
//
//  Created by Alex Ryan on 5/23/24.
//

import SwiftUI

extension Date {
    
    func firstLetterOfWeekday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Get full weekday name
        let fullWeekday = formatter.string(from: self)
        return String(fullWeekday.first!) // Get the first letter
    }
    
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }

    
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    // Checking if the date is today
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
        
    // Fetching Week based on date
    func fetchWeek(_ date: Date = .init()) -> [WeekDay] {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        
        var week: [WeekDay] = []
        let weekDate = calendar.dateInterval(of: .weekOfMonth, for: startDate)
        guard (weekDate?.start) != nil else {
            return []
        }
        
        // Iterating to get the full week
        (0..<7).forEach { index in
            if let weekDate = calendar.date(byAdding: .day, value: index, to: startDate) {
                week.append(.init(date: weekDate))
            }
        }
        
        return week
    }
    
    // Creating next week, based on the last current week date
    func createNextWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else {
            return []
        }
        
        return fetchWeek(nextDate)
    }
    
        // Creating previous week, based on the last current week date
    func createPreviousWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: -1, to: startOfLastDate) else {
            return []
        }
        
        return fetchWeek(nextDate)
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
    
}
