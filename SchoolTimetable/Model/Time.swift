//
//  Time.swift
//  Calendar
//
//  Created by Denis Dmitriev on 27.10.2023.
//

import Foundation

struct Time: Codable {
    let hour: Int
    let minutes: Int
    
    var timeString: String {
        let hourString = hour.formatted(.number)
        let minutesString = minutes == .zero ? "00" : minutes.formatted(.number)
        
        return hour.formatted(.number) + ":" + minutesString
    }
}
