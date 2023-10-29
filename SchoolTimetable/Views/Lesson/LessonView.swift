//
//  LessonView.swift
//  Calendar
//
//  Created by Denis Dmitriev on 29.10.2023.
//

import SwiftUI

struct LessonView: View {
    
    @State var lesson: Lesson?
    @State var headerSize: CGSize = .zero
    
    var body: some View {
        if let lesson {
            VStack(spacing: .zero) {
                ZStack {
                    Rectangle()
                        .fill(LinearGradient(colors: [lesson.color, lesson.color.opacity(0.75)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: headerSize.height)
                        .offset(y: -16)
                    
                    Text(lesson.subject)
                        .font(.title)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16).fill(.background)
                        )
                        .overlay {
                            GeometryReader { geometryProxy in
                                Color.clear.onAppear {
                                    headerSize = geometryProxy.size
                                }
                            }
                        }
                }
                .padding(.vertical)
                
                List {
                    Section {
                        HStack {
                            Text("Учителя")
                            Spacer()
                            VStack(alignment: .trailing) {
                                ForEach(lesson.teachers, id: \.self) { teacher in
                                    Text(teacher)
                                }
                            }
                        }
                        
                        HStack {
                            Text("Аудитория")
                            Spacer()
                            Text(lesson.classroom)
                        }
                        
                        HStack {
                            Text("Время")
                            Spacer()
                            Text(lesson.start.timeString + " – " + lesson.end.timeString)
                        }
                    }
                    
                    if let comments = lesson.comments {
                        Section("Заметки") {
                            Text(comments)
                        }
                    }
                    
                }
                .listStyle(.inset)
            }
        } else {
            placeholder
        }
    }
    
    var placeholder: some View {
        Text("Занятие не найдено")
            .font(.title2)
            .foregroundColor(.secondary)
    }
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        LessonView(lesson: Lesson.placeholder)
    }
}
