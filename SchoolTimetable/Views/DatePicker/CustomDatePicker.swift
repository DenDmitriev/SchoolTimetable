//
//  CustomDatePicker.swift
//  Calendar
//
//  Created by Denis Dmitriev on 28.10.2023.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @EnvironmentObject var store: DayStore
    @Binding var selection: Day.ID
    @State var currentMonth: Int = .zero
    @State var currentYear: Int = .zero
    var interval: DateInterval
    
    let weekdaySymbols: [String] = Calendar.weekdaySymbols(type: .short)
    let monthsSymbols = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                VStack(alignment: .leading) {
                    if let monthAndYear = extractMonthAndYear() {
                        Text(monthAndYear.year)
                            .font(.caption2)
                            .fontWeight(.semibold)
                        
                        Text(monthAndYear.month)
                            .font(.title3.bold())
                    }
                }
                
                Spacer(minLength: .zero)
                
                Button {
                    onAction(.previews)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                }
                .disabled(currentMonth == interval.start.monthNumber)
                
                Button {
                    onAction(.next)
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                }
                .disabled(currentMonth == interval.end.monthNumber)
                
            }
            .padding(.horizontal, 8)
            
            HStack(spacing: .zero) {
                ForEach(weekdaySymbols, id: \.self) { weekday in
                    Text(weekday)
                        .font(.callout)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
            }
            
            let columns = Array(repeating: GridItem(.flexible(minimum: 34)), count: 7)
            
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(daysMonth) { day in
                    Button {
                        withAnimation {
                            selection = day.id
                        }
                    } label: {
                        switch day {
                        case store.today:
                            DayNumberView(kind: .today, day: day)
                        case store[selection]:
                            DayNumberView(kind: .selected, day: day)
                        case _ where day.date.monthNumber != currentMonth:
                            DayNumberView(kind: .inactive, day: day)
                        default:
                            DayNumberView(kind: .active, day: day)
                        }
                    }
                }
            }
        }
        .padding(8)
        .onAppear {
            if let monthNumber = store[selection].date.monthNumber {
                currentMonth = monthNumber
            }
            if let yearNumber = store[selection].date.yearNumber {
                currentYear = yearNumber
            }
        }
    }
    
    private struct MonthAndYear {
        let month: String
        let year: String
    }
    
    private func extractMonthAndYear() -> MonthAndYear? {
        guard 1...12 ~= currentMonth else { return nil }
        return .init(month: monthsSymbols[currentMonth - 1], year: currentYear.description)
    }
    
    private enum Action {
        case previews, next
    }
    
    private func onAction(_ action: Action) {
        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, year: currentYear, month: currentMonth)
        var value: Int {
            switch action {
            case .previews:
                return -1
            case .next:
                return +1
            }
        }
        guard
            let currentDate = calendar.date(from: dateComponents),
            let someMonthDate = calendar.date(byAdding: .month, value: value, to: currentDate),
            let someMonth = someMonthDate.monthNumber
        else { return }
        
//        guard someMonthDate.isBetween(interval.start, and: interval.end) else { return }
        
        var lastMonth: Int {
            switch action {
            case .previews:
                return 1
            case .next:
                return 12
            }
        }
        
        if currentMonth == lastMonth {
            currentYear += value
        }
        currentMonth = someMonth
    }
    
    private func getDate(day: Int) -> Date {
        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, year: currentYear, month: currentMonth, day: day)
        
        guard
            let date = calendar.date(from: dateComponents)
        else { return Date() }
        
        return date
    }
    
    var daysMonth: [Day] {
        extractOffsetMonthDays(offset: .start)
        + extractMonthDays()
        + extractOffsetMonthDays(offset: .end)
    }
    
    private func extractMonthDays() -> [Day] {
        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, year: currentYear, month: currentMonth)
        guard
            let currentMonth = calendar.date(from: dateComponents)
        else { return [] }
        
        return currentMonth.getMonthDates().compactMap { date -> Day in
            let day = Day(date: date)
            return day
        }
    }
    
    enum Offset {
        case start, end
    }
    
    private func extractOffsetMonthDays(offset: Offset) -> [Day] {
        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, year: currentYear, month: currentMonth)
        guard
            let currentMonth = calendar.date(from: dateComponents)
        else { return [] }
        
        var dates: [Date] {
            switch offset {
            case .start:
                return currentMonth.getOffsetMonthDatesStart()
            case .end:
                return currentMonth.getOffsetMonthDatesEnd()
            }
        }
        return dates.compactMap { date -> Day in
            return Day(date: date)
        }
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        let dayStore = DayStore()
        CustomDatePicker(selection: .constant(dayStore.today.id), interval: dayStore.interval)
            .environmentObject(dayStore)
    }
}
