//
//  SchoolTimetableApp.swift
//  SchoolTimetable
//
//  Created by Denis Dmitriev on 24.10.2023.
//

import SwiftUI

@main
struct SchoolTimetableApp: App {
    
    @StateObject private var dayStore = DayStore()
    @StateObject private var timetableStore = TimetableStore()
    
    var body: some Scene {
        WindowGroup {
            let coordinator = Coordinator(timetableStore: timetableStore)
            ContentView(today: dayStore.today.id, selected: dayStore.selectedDay, coordinator: coordinator)
                .environmentObject(dayStore)
                .environmentObject(timetableStore)
        }
    }
}
