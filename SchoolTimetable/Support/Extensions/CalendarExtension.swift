//
//  CalendarExtension.swift
//  Calendar
//
//  Created by Denis Dmitriev on 25.10.2023.
// https://sarunw.com/posts/getting-number-of-days-between-two-dates/

import Foundation

extension Calendar {
    
    /// Calendar for Russian Moscow time zone
    static var calendar: Calendar = {
        var calendar = Calendar.current
        if let locale = Bundle.main.object(forInfoDictionaryKey: "Local") as? String {
            calendar.locale = Locale(identifier: locale)
        }
        if let timeZone = Bundle.main.object(forInfoDictionaryKey: "TimeZone") as? String {
            calendar.timeZone = TimeZone(identifier: timeZone) ?? .current
        }
        if let firstWeekday = Bundle.main.object(forInfoDictionaryKey: "FirstWeekday") as? Int {
            calendar.firstWeekday = firstWeekday
        }
        return calendar
    }()
    
    enum Interval {
        case year, remaining
    }
    
    /// Week of year
    static func weekOfYear() -> Int {
        let currentComponents = calendar.dateComponents([.weekOfYear], from: Date.now)
        return currentComponents.weekOfYear ?? .zero
    }
    
    /// Week count in year
    static func weeksOfYear(type: Interval) -> Int {
        guard
            let interval = calendar.dateInterval(of: .year, for: Date.now)
        else { return .zero }
        let fromDate = {
            switch type {
            case .year:
                return calendar.startOfDay(for: interval.start)
            case .remaining:
                return calendar.startOfDay(for: Date.now)
            }
        }()
        let toDate = calendar.startOfDay(for: interval.end)
        
        let weekOfYear = calendar.dateComponents([.weekOfYear], from: fromDate, to: toDate).weekOfYear
        
        return weekOfYear ?? .zero
    }
    
    /// Days in current year
    static func daysCount(year: Int? = nil) -> Int {
        let year = year ?? calendar.dateComponents([.year], from: Date.now).year
        guard
            let date = DateComponents(calendar: calendar, year: year).date,
            let interval = calendar.dateInterval(of: .year, for: date),
            let days = calendar.dateComponents([.year], from: interval.start, to: interval.end).day
        else { return .zero }
        
        return days
    }
    
    /// Days on week
    static func days(weekOfYear: Int) -> [Date] {
        let year = calendar.dateComponents([.year], from: Date.now).year
        let dateComponents = DateComponents(calendar: calendar, year: year, weekday: 2, weekOfYear: weekOfYear)
        guard
            let date = calendar.date(from: dateComponents),
            let interval = calendar.dateInterval(of: .weekOfMonth, for: date)
        else { return [] }
        
        var fromDate = calendar.startOfDay(for: interval.start)
        let toDate = calendar.startOfDay(for: interval.end)
        
        var result: [Date] = []
        
        while toDate > fromDate {
            result.append(fromDate)
            if let nextDate = calendar.date(byAdding: .day, value: 1, to: fromDate) {
                fromDate = nextDate
            } else {
                break
            }
        }
        
        return result
    }
    
    /// Day in week
    static func day(weekOfYear: Int, weekday: Int) -> Date? {
        let year = calendar.dateComponents([.year], from: Date.now).year
        let dateComponents = DateComponents(calendar: calendar, year: year, weekday: weekday + 1, weekOfYear: weekOfYear)
        let dateMonday = calendar.date(from: dateComponents)
        return dateMonday
    }
    
    enum WeekdaySymbols {
        case standard, short
    }
    
    /// Weekday symbols
    static func weekdaySymbols(type: WeekdaySymbols) -> [String] {
        var weekdaySymbols = {
            switch type {
            case .standard:
                return calendar.weekdaySymbols
            case .short:
                return calendar.shortWeekdaySymbols
            }
        }()
        // Bug in swift, firstWeekday not work
        if let sunday = weekdaySymbols.first {
            weekdaySymbols.remove(at: .zero)
            weekdaySymbols.append(sunday)
        }
        
        return weekdaySymbols
    }
    
    /// Number of days pass midnight, including a start date
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int? {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        if let days = numberOfDays.day {
            return days + 1 // We add another day to the result.
        } else {
            return nil
        }
    }
    
    /// Number of current day in month
    static func today() -> Int {
        return calendar.dateComponents([.day], from: Date()).day ?? .zero
    }
    
    /// Weekday of day. If date nil then date now
    static func weekday(date: Date? = nil) -> Int? {
        guard var weekday = calendar.dateComponents([.weekday], from: date ?? Date()).weekday else { return nil }
        if weekday == 1 {
            weekday = 7
        } else {
            weekday -= 1
        }
        return weekday
    }
    
    /// Weekday symbol of current day
    static func weekdaySymbol(date: Date? = nil) -> String? {
        guard var weekdayNumber = calendar.dateComponents([.weekday], from: date ?? Date()).weekday else { return nil }
        if weekdayNumber == 1 {
            weekdayNumber = 7
        } else {
            weekdayNumber -= 1
        }
        return weekdaySymbols(type: .standard)[weekdayNumber - 1]
    }
    
    /// First day midday date from number week of year
    static func firstDayOfWeekOfYear(weekOfYear: Int) -> Date? {
        let year = calendar.dateComponents([.year], from: Date.now).year
        let dateComponents = DateComponents(calendar: calendar, year: year, weekday: 2, weekOfYear: weekOfYear)
        
        return calendar.date(from: dateComponents)
    }
}
