//
//  Day.swift
//  Calendar
//
//  Created by Denis Dmitriev on 25.10.2023.
//

import Foundation

struct Day: Identifiable {
    let id: String
    let date: Date
    
    init(date: Date) {
        self.id = Self.createID(date: date)
        self.date = date
    }
    
    init?(id: Day.ID) {
        let array = id.split(separator: "-")
        guard
            array.count == 3,
            let day = Int(array[0]),
            let month = Int(array[1]),
            let year = Int(array[2])
        else { return nil }
        
        let dateComponents = DateComponents(calendar: Calendar.calendar, year: year, month: month, day: day)
        
        guard let date = Calendar.calendar.date(from: dateComponents) else { return nil }
        
        self.id = id
        self.date = date
    }
    
    static func createID(date: Date) -> Day.ID {
        if let day = date.dayNumber, let month = date.monthNumber, let year = date.yearNumber {
            return day.formatted(.number) + "-" + month.formatted(.number) + "-" + "\(year)"
        } else {
            return "00-00-00"
        }
    }
}

extension Day: Hashable {
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

extension Day: Comparable {
    static func < (lhs: Day, rhs: Day) -> Bool {
        lhs.date < rhs.date
    }
    
    static func == (lhs: Day, rhs: Day) -> Bool {
        lhs.id == rhs.id
    }
    
    static func ~=(lhs: Day, rhs: [Day]) -> Bool {
        return rhs.contains(where: { $0.id == lhs.id })
    }
}

extension Day {
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru-RU")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "d MMMM"
        
        return dateFormatter.string(from: date)
    }
    
    var weekdayString: String {
        let weekday = Calendar.weekdaySymbol(date: date) ?? ""
        return weekday
    }
    
    var weekday: Int {
        let weekday = Calendar.weekday(date: date) ?? .zero
        return weekday
    }
    
    var weekOfYear: Int {
        guard let weekOfYear = Calendar.calendar.dateComponents([.weekOfYear], from: date).weekOfYear
        else { return .zero }
        return weekOfYear
    }
    
    var month: String {
        guard let month = Calendar.calendar.dateComponents([.month], from: date).month
        else { return "N/A" }
        let months = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
        return months[month - 1]
    }
    
    var year: String {
        guard let year = Calendar.calendar.dateComponents([.year], from: date).year else { return "" }
        return year.description
    }
    
    var monthAndYear: String {
        month + " " + year
    }
    
    var number: Int {
        guard let day = Calendar.calendar.dateComponents([.day], from: date).day
        else { return .zero }
        return day
    }
    
    func dateText(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru-RU")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
}

extension Day {
    static var placeholder: Self {
        Day(date: Date.now)
    }
    
    static var today: Self {
        Day(date: Date.now)
    }
}
