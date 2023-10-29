//
//  DateExtensions.swift
//  Calendar
//
//  Created by Denis Dmitriev on 25.10.2023.
//

import Foundation

extension Date {
    
    func tomorrow() -> Date? {
        let calendar = Calendar.calendar
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: self)
        return tomorrow
    }
    
    func dayAfterTomorrow() -> Date? {
        let calendar = Calendar.calendar
        let tomorrow = calendar.date(byAdding: .day, value: 2, to: self)
        return tomorrow
    }
    
    func yesterday() -> Date? {
        let calendar = Calendar.calendar
        let yesterday = calendar.date(byAdding: .day, value: -1, to: self)
        return yesterday
    }
    
    func dayBeforeYesterday() -> Date? {
        let calendar = Calendar.calendar
        let yesterday = calendar.date(byAdding: .day, value: -2, to: self)
        return yesterday
    }
    
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
    
    var startOfWeek: Date? {
        let calendar = Calendar.calendar
        return calendar.dateInterval(of: .weekOfMonth, for: self)?.start
    }
    
    var endOfWeek: Date? {
        let calendar = Calendar.calendar
        return calendar.dateInterval(of: .weekOfMonth, for: self)?.end
    }
    
    var startOfMonth: Date? {
        let calendar = Calendar.calendar
        return calendar.dateInterval(of: .month, for: self)?.start
    }
    
    var endOfMonth: Date? {
        let calendar = Calendar.calendar
        return calendar.dateInterval(of: .month, for: self)?.end
    }
    
    var weekNumber: Int? {
        let calendar = Calendar.calendar
        let currentComponents = calendar.dateComponents([.weekOfYear], from: self)
        return currentComponents.weekOfYear
    }
    
    var monthNumber: Int? {
        let calendar = Calendar.calendar
        let currentComponents = calendar.dateComponents([.month], from: self)
        return currentComponents.month
    }
    
    var dayNumber: Int? {
        let calendar = Calendar.calendar
        let currentComponents = calendar.dateComponents([.day], from: self)
        return currentComponents.day
    }
    
    var yearNumber: Int? {
        let calendar = Calendar.calendar
        let currentComponents = calendar.dateComponents([.year], from: self)
        return currentComponents.year
    }
    
    
    func getOffsetMonthDatesStart() -> [Date] {
        let calendar = Calendar.current
        
        guard
            let month: Int = self.monthNumber,
            let year: Int = self.yearNumber
        else { return [] }
        
        let dateComponents = DateComponents(calendar: calendar, year: year, month: month)
        guard
            let date = calendar.date(from: dateComponents),
            let interval = calendar.dateInterval(of: .month, for: date)
        else { return [] }
        
        let startOfMonth = calendar.startOfDay(for: interval.start)
        
        guard
            let startOfWeek = startOfMonth.startOfWeek
        else { return [] }
        
        var someDayOfWeek = startOfWeek
        
        var result: [Date] = []
        
        while someDayOfWeek < startOfMonth {
            result.append(someDayOfWeek)
            if let nextDayOfWeek = calendar.date(byAdding: .day, value: 1, to: someDayOfWeek) {
                someDayOfWeek = nextDayOfWeek
            }
        }
        
        return result
    }
    
    func getOffsetMonthDatesEnd() -> [Date] {
        let calendar = Calendar.current
        
        guard
            let month: Int = self.monthNumber,
            let year: Int = self.yearNumber
        else { return [] }
        
        let dateComponents = DateComponents(calendar: calendar, year: year, month: month)
        guard
            let date = calendar.date(from: dateComponents),
            let interval = calendar.dateInterval(of: .month, for: date)
        else { return [] }
        
        let endDayMonth = calendar.startOfDay(for: interval.end)
        
        guard
            let endOfWeek = endDayMonth.endOfWeek
        else { return [] }
        
        var someDayOfWeek = endDayMonth
        
        var result: [Date] = []
        
        while someDayOfWeek < endOfWeek {
            result.append(someDayOfWeek)
            if let previewsDayOfWeek = calendar.date(byAdding: .day, value: 1, to: someDayOfWeek) {
                someDayOfWeek = previewsDayOfWeek
            }
        }
        
        return result
    }
    
    func getMonthDates() -> [Date] {
        let calendar = Calendar.current
        
        guard
            let month: Int = self.monthNumber,
            let year: Int = self.yearNumber
        else { return [] }
        
        let dateComponents = DateComponents(calendar: calendar, year: year, month: month)
        guard
            let date = calendar.date(from: dateComponents),
            let interval = calendar.dateInterval(of: .month, for: date)
        else { return [] }
        
        let startDayMonth = calendar.startOfDay(for: interval.start)
        let endDayMonth = calendar.startOfDay(for: interval.end)
        
        var someDayMonth = startDayMonth
        var dates: [Date] = []
        while someDayMonth < endDayMonth {
            dates.append(someDayMonth)
            if let nextDayDate = calendar.date(byAdding: .day, value: 1, to: someDayMonth) {
                someDayMonth = nextDayDate
            }
        }
        
        return dates
    }
}
