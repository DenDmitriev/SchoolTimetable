//
//  CalendarLineView.swift
//  Calendar
//
//  Created by Denis Dmitriev on 27.10.2023.
//

import SwiftUI

struct CalendarLineView: View {
    
    @EnvironmentObject var store: DayStore
    
    @Binding var selection: Day.ID
    @Binding var today: Day.ID
    @Binding var selectedWeek: Int
    
    let weeks: Int = Calendar.weeksOfYear(type: .year)
    let week: Int = Calendar.weekOfYear()
    let weekdaySymbols: [String] = Calendar.weekdaySymbols(type: .short)
    
    @State private var tabViewSize: CGSize?
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                ForEach(weekdaySymbols, id: \.self) { weekday in
                    Text(weekday)
                }
                .font(.caption)
                .frame(maxWidth: .infinity)
            }
            
            TabView(selection: $selectedWeek) {
                ForEach(Array(week...weeks), id: \.self) { week in
                    DaysWeekView(week: week, selection: $selection, today: $today)
                }
                .overlay {
                    GeometryReader { geometryReader in
                        Color.clear.onAppear {
                            if tabViewSize == nil {
                                tabViewSize = geometryReader.size
                            }
                        }
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.default, value: selectedWeek)
            .frame(height: tabViewSize?.height ?? 100)
        }
        .padding(10)
    }
}

struct CalendarLineView_Previews: PreviewProvider {
    static var previews: some View {
        let dayStore = DayStore()
        CalendarLineView(selection: .constant(dayStore.today.id), today: .constant(dayStore.today.id), selectedWeek: .constant(Calendar.weekOfYear()))
            .environmentObject(dayStore)

    }
}
