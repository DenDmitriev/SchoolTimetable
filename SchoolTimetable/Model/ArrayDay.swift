//
//  Array<Day>.swift
//  Calendar
//
//  Created by Denis Dmitriev on 26.10.2023.
//

import Foundation

extension Array<Day> {
    enum DayType {
        case today
        case firstDayOfWeek(day: Day)
        case lastDayOfWeek(day: Day)
        case dayAfterWeek(day: Day)
        case dayBeforeWeek(day: Day)
        case middleDayOfWeek(day: Day)
        case dayOnCurrentWeek(weekday: Int)
    }
    
    // MARK: - Public methods
    
    func day(of type: DayType) -> Day? {
        switch type {
        case .today:
            return today()
        case .firstDayOfWeek(let day):
            return firstDayOfWeek(day: day)
        case .lastDayOfWeek(let day):
            return lastDayOfWeek(day: day)
        case .dayAfterWeek(let day):
            return dayAfterWeek(day: day)
        case .dayBeforeWeek(let day):
            return dayBeforeWeek(day: day)
        case .middleDayOfWeek(let day):
            return middleDayOfWeek(day: day)
        case .dayOnCurrentWeek(let weekday):
            return dayOnCurrentWeek(weekday: weekday)
        }
    }
    
    func pasts() -> [Day.ID] {
        var pasts: [Day.ID] = []
        guard let today = self.today() else { return pasts }
        for day in self {
            if day.date < today.date {
                pasts.append(day.id)
            } else {
                break
            }
        }
        return pasts
    }
    
    // MARK: - Private methods
    
    private func today() -> Day? {
        let currentDay = self.first(where: { $0.number == Calendar.today() })
        return currentDay
    }
    
    private func middleDayOfWeek(day: Day) -> Day? {
        guard
            var weekday = Calendar.calendar.dateComponents([.weekday], from: day.date).weekday,
            let index = self.firstIndex(of: day)
        else { return nil }
        if weekday == 1 {
            weekday = 7
        } else {
            weekday -= 1
        }
        if weekday == 4 {
            return day
        } else {
            let isFirstPartWeek = weekday < 4
            let delta = isFirstPartWeek ? 4 - weekday : weekday - 4
            let middleDayOfWeek = isFirstPartWeek ? index + delta : index - delta
            if 0...self.index(before: self.count) ~= middleDayOfWeek {
                return self[middleDayOfWeek]
            } else {
                return nil
            }
        }
    }
    
    private func firstDayOfWeek(day: Day) -> Day? {
        guard
            var weekday = Calendar.calendar.dateComponents([.weekday], from: day.date).weekday,
            let index = self.firstIndex(of: day)
        else { return nil }
        if weekday == 1 {
            weekday = 7
        } else {
            weekday -= 1
        }
        let delta = weekday - 1
        let firstDayOfWeekIndex = index - delta
        if firstDayOfWeekIndex >= 0 {
            return self[firstDayOfWeekIndex]
        } else {
            return nil
        }
    }
    
    private func lastDayOfWeek(day: Day) -> Day? {
        guard
            var weekday = Calendar.calendar.dateComponents([.weekday], from: day.date).weekday,
            let index = self.firstIndex(of: day)
        else { return nil }
        if weekday == 1 {
            weekday = 7
        } else {
            weekday -= 1
        }
        let delta = 7 - weekday
        let lastDayOfWeekIndex = index + delta
        if lastDayOfWeekIndex <= self.index(before: self.count) {
            return self[lastDayOfWeekIndex]
        } else {
            return nil
        }
    }
    
    private func dayAfterWeek(day: Day) -> Day? {
        guard
            let index = self.firstIndex(of: day)
        else { return nil }
        let delta = 7
        let dayAfterWeekIndex = index + delta
        if dayAfterWeekIndex <= self.index(before: self.count) {
            return self[dayAfterWeekIndex]
        } else {
            return nil
        }
    }
    
    private func dayBeforeWeek(day: Day) -> Day? {
        guard
            let index = self.firstIndex(of: day)
        else { return nil }
        let delta = 7
        let dayBeforeWeekIndex = index - delta
        if dayBeforeWeekIndex >= 0 {
            return self[dayBeforeWeekIndex]
        } else {
            return nil
        }
    }
    
    private func dayOnCurrentWeek(weekday: Int) -> Day? {
        if weekday <= self.index(before: self.count) {
            return self[weekday]
        } else {
            return nil
        }
    }
}
