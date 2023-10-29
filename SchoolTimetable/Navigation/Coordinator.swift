//
//  Coordinator.swift
//  Calendar
//
//  Created by Denis Dmitriev on 29.10.2023.
//

import Foundation

final class Coordinator: ObservableObject {
    let timetableViewModel: TimetableViewModel
    
    init(timetableStore: TimetableStore) {
        timetableViewModel = TimetableViewModel(timetableStore: timetableStore)
    }
}
