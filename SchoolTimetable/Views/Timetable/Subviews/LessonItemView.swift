//
//  LessonView.swift
//  Calendar
//
//  Created by Denis Dmitriev on 27.10.2023.
//

import SwiftUI

struct LessonItemView: View {
    
    let lesson: Lesson
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TimeIntervalView(start: lesson.start, end: lesson.end)
                
                Spacer()
                
                Text(lesson.classroom)
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }

            Text(lesson.subject)
                .font(.title3)
            
            if let comments = lesson.comments {
                Text(comments)
                    .font(.caption)
                    .lineLimit(2)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay {
            ZStack {
                HStack {
                    Rectangle()
                        .fill(lesson.color)
                        .frame(width: 6)
                    
                    Color.clear
                }
                
                Rectangle()
                    .fill(lesson.color)
                    .opacity(0.2)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct LessonItemView_Previews: PreviewProvider {
    static var previews: some View {
        LessonItemView(lesson: .placeholder)
            .previewLayout(.fixed(width: 400, height: 150))
    }
}
