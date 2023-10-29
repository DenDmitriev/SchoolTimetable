//
//  Store.swift
//  Calendar
//
//  Created by Denis Dmitriev on 26.10.2023.
//

import Foundation

final class DayStore: ObservableObject {
    @Published var selectedDay: Day.ID = Day.today.id
    
    init() {}
    
    subscript(dayID: Day.ID?) -> Day {
        get {
            if let id = dayID {
                return Day(id: id) ?? .placeholder
            }
            return .placeholder
        }

//        set(newValue) {
//            if let id = dayID {
//                days[days.firstIndex(where: { $0.id == id })!] = newValue
//            }
//        }
    }
    
    var interval: DateInterval {
        guard
            let startInterval = Calendar.calendar.dateInterval(of: .weekOfMonth, for: Date.now),
            let endInterval = Calendar.calendar.dateInterval(of: .year, for: Date.now)
        else { return DateInterval(start: Date.now, end: Date.now + 1) }
        
        let start = startInterval.start
        let end = endInterval.end
        
        return DateInterval(start: start, end: end)
    }
    
    var today: Day {
        return Day(date: Date.now)
    }
    
    var tomorrow: Day {
        let tomorrowDate = Date.now.tomorrow() ?? Date.now
        return Day(date: tomorrowDate)
    }
    
    var yesterday: Day {
        let yesterdayDate = Date.now.yesterday() ?? Date.now
        return Day(date: yesterdayDate)
    }
    
    var dayAfterTomorrow: Day {
        let yesterdayDate = Date.now.dayAfterTomorrow() ?? Date.now
        return Day(date: yesterdayDate)
    }
    
    var dayBeforeYesterday: Day {
        let yesterdayDate = Date.now.dayBeforeYesterday() ?? Date.now
        return Day(date: yesterdayDate)
    }
}
