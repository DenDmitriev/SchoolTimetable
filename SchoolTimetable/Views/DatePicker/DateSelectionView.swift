//
//  DateSelectionView.swift
//  Calendar
//
//  Created by Denis Dmitriev on 28.10.2023.
//
// Custom https://www.youtube.com/watch?v=pOSQr7DI310

import SwiftUI

struct DateSelectionView: View {
    
    @EnvironmentObject var store: DayStore
    @Binding var selection: Day.ID
    
    let datePartialRange: PartialRangeFrom<Date> = {
        let calendar = Calendar.current
        return (Date.now.startOfWeek ?? Date.now)...
    }()

    var body: some View {
        DatePicker(
            selection: date,
            in: datePartialRange,
            displayedComponents: [.date]
        ) {
            Label("", systemImage: "calendar")
        }
        .labelsHidden()
        .datePickerStyle(.compact)
        .environment(\.locale, Calendar.calendar.locale ?? Locale(identifier: "ru-RU"))
        .environment(\.calendar, Calendar.calendar)
    }
    
    private var date: Binding<Date> {
        Binding(get: { store[selection].date }, set: { selection = Day(date: $0).id })
    }
}

struct DateSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DateSelectionView(selection: .constant(Day.placeholder.id))
            .environmentObject(DayStore())
    }
}
