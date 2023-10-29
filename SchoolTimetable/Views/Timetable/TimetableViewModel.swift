//
//  TimetableViewModel.swift
//  Calendar
//
//  Created by Denis Dmitriev on 24.10.2023.
//

import SwiftUI

class TimetableViewModel: ObservableObject {
    
    var timetableStore: TimetableStore
    @Published var timetable: Timetable?
    
    init(timetableStore: TimetableStore, timetable: Timetable? = nil) {
        self.timetableStore = timetableStore
        self.timetable = timetable
    }
    
    func fetchTimetable(date: Date) {
        let day = Day(date: date)
        if let cacheTimetable = timetableStore[day.id] {
            self.timetable = cacheTimetable
        } else {
            let isDateInWeekend = Calendar.calendar.isDateInWeekend(date)
            if isDateInWeekend {
                self.timetable = nil
            } else {
                let timetable = TimetableMockBuilder.build(for: date)
                timetableStore[day.id] = timetable
                self.timetable = timetable
            }
        }
    }
}
