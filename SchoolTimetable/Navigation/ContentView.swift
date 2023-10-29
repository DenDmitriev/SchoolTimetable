//
//  ContentView.swift
//  Calendar
//
//  Created by Denis Dmitriev on 24.10.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dayStore: DayStore
    @EnvironmentObject var timetableStore: TimetableStore
    @State private var selectedDayID: Day.ID
    @State private var todayDayID: Day.ID
    
    let coordinator: Coordinator
    
    init(today: Day.ID, selected: Day.ID, coordinator: Coordinator) {
        selectedDayID = selected
        todayDayID = today
        self.coordinator = coordinator
    }
    
    var body: some View {
        DayView(selection: $selectedDayID, today: $todayDayID)
            .environmentObject(coordinator)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let dayStore = DayStore()
        let timetableStore = TimetableStore()
        let coordinator = Coordinator(timetableStore: timetableStore)
        ContentView(today: dayStore.today.id, selected: dayStore.selectedDay, coordinator: coordinator)
            .environmentObject(dayStore)
            .environmentObject(timetableStore)
    }
}
