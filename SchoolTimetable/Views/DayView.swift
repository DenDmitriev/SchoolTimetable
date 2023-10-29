//
//  DayView.swift
//  Calendar
//
//  Created by Denis Dmitriev on 24.10.2023.
//

import SwiftUI

struct DayView: View {
    
    @EnvironmentObject var store: DayStore
    @EnvironmentObject var timetableStore: TimetableStore
    @EnvironmentObject var coordinator: Coordinator
    @Binding var selection: Day.ID
    @Binding var today: Day.ID
    @State var selectedWeek = Calendar.weekOfYear()
    @State private var showingPopover = false
    
    var body: some View {
        VStack(spacing: .zero) {
            
            HStack {
                Button {
                    showingPopover.toggle()
                } label: {
                    Label(store[selection].monthAndYear, systemImage: "calendar")
                }
                .popover(isPresented: $showingPopover) {
                    CustomDatePicker(selection: $selection, interval: store.interval)
                        .presentationBackground(.ultraThinMaterial)
                        .presentationCompactAdaptation(.popover)
                    
                }
                
                Spacer()
                
                CalendarLineControlView(today: $today, selection: $selection, selectedWeek: $selectedWeek)
                
//                DateSelectionView(selection: $selection)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            
            Divider()
            
            CalendarLineView(selection: $selection, today: $today, selectedWeek: $selectedWeek)
                .onChange(of: selection) { newSelection in
                    if let newSelectedWeek = store[newSelection].date.weekNumber {
                        selectedWeek = newSelectedWeek
                        let date = store[selection].date
                        timetableStore.fetchWeek(date: date)
                    }
                }
            
            Divider()
            
            HStack {
                Text("Расписание")
                    .padding(.horizontal)
                Spacer()
                DateView(selection: $selection)
            }
            
            Divider()
            
            TimetableView(viewModel: coordinator.timetableViewModel, day: $selection)
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        let dayStore = DayStore()
        let timetableStore = TimetableStore()
        let coordinator = Coordinator(timetableStore: timetableStore)
        DayView(selection: .constant(dayStore.today.id), today: .constant(dayStore.today.id))
            .environmentObject(dayStore)
            .environmentObject(timetableStore)
            .environmentObject(coordinator)
    }
}
