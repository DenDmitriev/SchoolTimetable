//
//  Timetable.swift
//  Calendar
//
//  Created by Denis Dmitriev on 24.10.2023.
//

import Foundation

struct Timetable: Codable {
    let date: Date
    let `class`: String
    let lessons: [Lesson]
}
