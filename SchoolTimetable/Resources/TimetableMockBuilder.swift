//
//  TimetableMockBuilder.swift
//  Calendar
//
//  Created by Denis Dmitriev on 26.10.2023.
//

import Foundation

final class TimetableMockBuilder {
    
    static private var `class`: String = "7Б"
    
    static func build(for date: Date) -> Timetable {
        var lessons: [Lesson] = []
        let lessonsCount = Int.random(in: 1...beginlessonTime.index(before: beginlessonTime.count))
        for lessonNumber in 0...lessonsCount {
            let subject = Lorem.subject
            let classroom = Lorem.classroom
            let beginlessonTime = beginlessonTime[lessonNumber]
            let endLessonTime = endLessonTime(start: beginlessonTime)
            let start = Time(hour: beginlessonTime.hour ?? 0, minutes: beginlessonTime.minute ?? 0)
            let end = Time(hour: endLessonTime.hour ?? 0, minutes: endLessonTime.minute ?? 0)
            let lesson = Lesson(subject: subject,
                                classroom: classroom,
                                start: start,
                                end: end,
                                teachers: teachers(),
                                priority: Priority.allCases.randomElement()?.rawValue ?? 5,
                                comments: Lorem.sentence)
            lessons.append(lesson)
        }
        return Timetable(date: date, class: `class`, lessons: lessons)
    }
    
    static private let beginlessonTime: [DateComponents] = [
        DateComponents(hour: 8, minute: 0),
        DateComponents(hour: 9, minute: 0),
        DateComponents(hour: 10, minute: 0),
        DateComponents(hour: 11, minute: 0),
        DateComponents(hour: 12, minute: 0),
        DateComponents(hour: 13, minute: 0),
    ]
    
    static private func endLessonTime(start: DateComponents) -> DateComponents {
        var end = start
        end.minute = (start.minute ?? 0) + 40
        return end
    }
    
    static func teachers() -> [String] {
        var teachers = [String]()
        for _ in 0...Int.random(in: 0...1) {
            teachers.append(Lorem.fullName)
        }
        return teachers
    }
}

extension Lorem {
    // ======================================================= //
    // MARK: - Subjects
    // ======================================================= //
    
    static let subjects: [String] = ["Русский язык", "Литература", "Иностранный язык", "Математика", "Информатика", "Физика", "Химия", "Биология", "География", "История", "Обществознание", "Экономика", "Право", "Физическая культура", "ОБЖ", "Культура", "Технология", "Черчение", "Экология", "Психология", "ИЗО", "Музыка"]
    
    /// Generates subject.
    public static var subject: String {
        let subject = subjects.randomElement()!
        
        return subject
    }
    
    // ======================================================= //
    // MARK: - Classrooms
    // ======================================================= //
    
    public static var classroom: String {
        var result: String = ""
        let random = Int.random(in: 1...9)
        switch random {
        case 1:
            result = "Актовый зал"
        case 2:
            result = "Спорт зал"
        case 7...9:
            result = Int.random(in: 100...999).formatted(.number) + (["A", "Б", "C", "Д", "Е"].randomElement() ?? "")
        default:
            result = Int.random(in: 100...999).formatted(.number)
        }
        return result
    }
}
