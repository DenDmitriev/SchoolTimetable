//
//  DayNumberView.swift
//  Calendar
//
//  Created by Denis Dmitriev on 26.10.2023.
//

import SwiftUI

struct DayNumberView: View {
    
    enum Kind: CaseIterable {
        case inactive, today, selected, active
    }
    
    @EnvironmentObject var timetableStore: TimetableStore
    @State var kind: Kind
    @State var day: Day
    
    var body: some View {
        VStack(spacing: 0) {
            switch kind {
            case .inactive:
                number
                    .foregroundColor(.secondary)
            case .today:
                number
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
            case .active:
                number
                    .foregroundColor(.primary)
            case .selected:
                number
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
            }
            
            if let timetable = timetableStore[day.id] {
                let columns: [GridItem] = Array(repeating: GridItem(.fixed(0), spacing: 4), count: 6)
                LazyVGrid(columns: columns, alignment: .center, spacing: 1) {
                    ForEach(timetable.lessons) { lesson in
                        switch kind {
                        case .selected, .today:
                            Circle()
                                .fill(lesson.color)
                                .frame(width: 3)
                        case .inactive:
                            Circle()
                                .fill(lesson.color)
                                .frame(width: 3)
                        default:
                            Circle()
                                .fill(lesson.color)
                                .frame(width: 3)
                        }
                    }
                }
            }
        }
        .frame(width: 34, height: 48)
        .background {
            switch kind {
            case .today:
                Capsule()
                    .fill(.primary)
            case .selected:
                Capsule()
                    .fill(.secondary)
            default:
                Capsule()
                    .fill(.clear)
            }
            
        }
    }
    
    var number: some View {
        Text(day.number.formatted(.number))
            .font(.title3)
    }
}

struct DayNumberView_Previews: PreviewProvider {
    
    static var previews: some View {
        let timetableStore: TimetableStore = {
            let store = TimetableStore()
            store[Day.placeholder.id] = TimetableMockBuilder.build(for: Day.placeholder.date)
            return store
        }()
        
        VStack {
            ForEach(DayNumberView.Kind.allCases, id: \.self) { type in
                DayNumberView(kind: type, day: Day.placeholder)
            }
        }
        .environmentObject(timetableStore)
        .previewLayout(.fixed(width: 100, height: 100 * Double(DayNumberView.Kind.allCases.count)))
    }
}
