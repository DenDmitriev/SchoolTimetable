//
//  Lesson.swift
//  Calendar
//
//  Created by Denis Dmitriev on 24.10.2023.
//

import Foundation

struct Lesson: Codable, Identifiable {
    let subject: String
    let classroom: String
    let start: Time
    let end: Time
    let teachers: [String]
    let priority: Int
    let comments: String?
    
    var id: UUID = {
        UUID()
    }()
}

extension Lesson: Hashable, Equatable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Lesson, rhs: Lesson) -> Bool {
        lhs.id == rhs.id
    }
}

extension Lesson {
    static let placeholder = Lesson(
        subject: Lorem.subject,
        classroom: Lorem.classroom,
        start: Time(hour: 9, minutes: 0),
        end: Time(hour: 9, minutes: 40),
        teachers: TimetableMockBuilder.teachers(),
        priority: 5,
        comments: Lorem.sentence
    )
}
