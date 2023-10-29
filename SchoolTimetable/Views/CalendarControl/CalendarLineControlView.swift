//
//  CalendarLineControlView.swift
//  Calendar
//
//  Created by Denis Dmitriev on 27.10.2023.
//

import SwiftUI

struct CalendarLineControlView: View {
    
    @EnvironmentObject var store: DayStore
    @Binding var today: Day.ID
    @Binding var selection: Day.ID
    @Binding var selectedWeek: Int
    
    let weeksOfYear = Calendar.weeksOfYear(type: .year)
    let currentWeek = Calendar.weekOfYear()
    
    var body: some View {
        HStack {
            Button {
                updateSelection(to: .previews)
                goWeek(to: .previews)
            } label: {
                Image(systemName: "chevron.left")
            }
            .disabled(selectedWeek == currentWeek)
            
            Button {
                selection = today
            } label: {
                Text("Сегодня")
            }
            .disabled(today == selection)
            
            Button {
                updateSelection(to: .next)
                goWeek(to: .next)
            } label: {
                Image(systemName: "chevron.right")
            }
            .disabled(selectedWeek == weeksOfYear)
        }
        .padding(10)
    }
    
    enum Action {
        case next
        case previews
    }
    
    private func goWeek(to: Action) {
        switch to {
        case .next:
            if selectedWeek < weeksOfYear {
                selectedWeek += 1
            }
        case .previews:
            if selectedWeek > currentWeek  {
                selectedWeek -= 1
            }
        }
        
    }
    
    private func updateSelection(to: Action) {
        switch to {
        case .next:
            if selectedWeek < weeksOfYear,
               let weekday = Calendar.weekday(date: store[selection].date),
               let date = Calendar.day(weekOfYear: selectedWeek + 1, weekday: weekday) {
                selection = Day(date: date).id
            }
        case .previews:
            if selectedWeek > currentWeek,
               let weekday = Calendar.weekday(date: store[selection].date),
               let date = Calendar.day(weekOfYear: selectedWeek - 1, weekday: weekday) {
                selection = Day(date: date).id
            }
        }
    }
}

struct CalendarLineControlView_Previews: PreviewProvider {
    static var previews: some View {
        let store = DayStore()
        CalendarLineControlView(today: .constant(Day.placeholder.id), selection: .constant(Day.placeholder.id), selectedWeek: .constant(Calendar.weekOfYear()))
            .environmentObject(store)
    }
}
