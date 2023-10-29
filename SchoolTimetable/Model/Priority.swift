//
//  Priority.swift
//  Calendar
//
//  Created by Denis Dmitriev on 29.10.2023.
//

import SwiftUI

enum Priority: Int, CaseIterable {
    case one, two, three, four, five, six, seven
    
    var color: Color {
        switch self {
        case .one:
            return .red
        case .two:
            return .orange
        case .three:
            return .yellow
        case .four:
            return .green
        case .five:
            return .blue
        case .six:
            return .cyan
        case .seven:
            return .gray
        }
    }
}


extension Lesson {
    var color: Color {
        return Priority(rawValue: self.priority)?.color ?? .gray
    }
}
