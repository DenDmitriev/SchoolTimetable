//
//  TimeIntervalView.swift
//  Calendar
//
//  Created by Denis Dmitriev on 27.10.2023.
//

import SwiftUI

struct TimeIntervalView: View {
    let start: Time
    let end: Time
    
    var body: some View {
        HStack {
            Text(start.timeString)
            Text("–")
            Text(end.timeString)
        }
        .font(.headline)
        .foregroundColor(.secondary)
    }
}

struct TimeIntervalView_Previews: PreviewProvider {
    static var previews: some View {
        TimeIntervalView(start: Time(hour: 9, minutes: 0), end: Time(hour: 9, minutes: 40))
    }
}
