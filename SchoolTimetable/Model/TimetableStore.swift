//
//  TimetableStore.swift
//  Calendar
//
//  Created by Denis Dmitriev on 29.10.2023.
//

import Foundation

final class TimetableStore: ObservableObject {
    private var cache: Cache<Day.ID, Timetable>
    
    init() {
        self.cache = .init()
        fetchWeek()
    }
    
    subscript(dayID: Day.ID) -> Timetable? {
        get {
            if let value = cache.value(forKey: dayID) {
                return value
            } else {
                return nil
            }
        }
        set(newValue) {
            if let newValue {
                cache.insert(newValue, forKey: dayID)
            }
        }
    }
    
    func fetchWeek(date: Date? = nil) {
        let date: Date = date ?? Date.now
        guard
            var start = date.startOfWeek,
            let end = date.endOfWeek
        else { return }
        while start < end {
            if !Calendar.calendar.isDateInWeekend(start) {
                let day = Day(date: start)
                if cache[day.id] == nil {
                    cache[day.id] = TimetableMockBuilder.build(for: start)
                }
            }
            if let someDayOnWeek = Calendar.calendar.date(byAdding: .day, value: 1, to: start) {
                start = someDayOnWeek
            }
        }
    }
}
