//
//  DateService.swift
//  Calendar
//
//  Created by Denis Dmitriev on 27.10.2023.
//

import Foundation

final class DateService {
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru-RU")
        dateFormatter.dateFormat = "dd MMMM"
        
        return dateFormatter
    }()
    
    static let monthFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru-RU")
        dateFormatter.dateFormat = "MMMM YYYY"
        
        return dateFormatter
    }()
}
