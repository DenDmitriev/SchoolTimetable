//
//  DateView.swift
//  Calendar
//
//  Created by Denis Dmitriev on 28.10.2023.
//

import SwiftUI

struct DateView: View {
    @EnvironmentObject var store: DayStore
    @Binding var selection: Day.ID
    
    var body: some View {
        Text(dateString())
            .padding(.horizontal)
            .padding(.vertical, 10)
    }
    
    private func dateString() -> String {
        let dateString = DateService.dateFormatter.string(from: store[selection].date)
        switch selection {
        case store.dayBeforeYesterday.id:
            return "Позавчера" + ", " + dateString
        case store.yesterday.id:
            return "Вчера" + ", " + dateString
        case store.today.id:
            return "Сегодня" + ", " + dateString
        case store.tomorrow.id:
            return "Завтра" + ", " + dateString
        case store.dayAfterTomorrow.id:
            return "Послезавтра" + ", " + dateString
        default:
            return dateString
        }
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(selection: .constant(Day.placeholder.id))
            .environmentObject(DayStore())
    }
}
