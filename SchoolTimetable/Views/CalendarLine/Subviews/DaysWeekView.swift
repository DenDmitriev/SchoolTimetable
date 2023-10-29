//
//  DaysWeekView.swift
//  Calendar
//
//  Created by Denis Dmitriev on 27.10.2023.
//

import SwiftUI

struct DaysWeekView: View {
    
    let week: Int
    @Binding var selection: Day.ID
    @Binding var today: Day.ID
    
    var body: some View {
        HStack(spacing: .zero) {
            ForEach(days(of: week)) { day in
                Button {
                    selection = day.id
                } label: {
                    switch day.id {
                    case today:
                        DayNumberView(kind: .today, day: day)
                    case selection:
                        DayNumberView(kind: .selected, day: day)
                    case _ where day.date < Date.now:
                        DayNumberView(kind: .inactive, day: day)
                    default:
                        DayNumberView(kind: .active, day: day)
                    }
                }
                .id(day)
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    private func days(of week: Int) -> [Day] {
        return Calendar.days(weekOfYear: week).map { date in
            Day(date: date)
        }
    }
}

struct DaysWeekView_Previews: PreviewProvider {
    static var previews: some View {
        DaysWeekView(week: 43, selection: .constant(Day.placeholder.id), today: .constant(Day.placeholder.id))
    }
}
