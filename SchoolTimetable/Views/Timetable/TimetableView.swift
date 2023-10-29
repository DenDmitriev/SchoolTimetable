//
//  TimetableView..swift
//  Calendar
//
//  Created by Denis Dmitriev on 24.10.2023.
//

import SwiftUI

struct TimetableView: View {
    
    @EnvironmentObject var store: DayStore
    @ObservedObject var viewModel: TimetableViewModel
    @State var timetable: Timetable?
    @Binding var day: Day.ID
    @State var showTimetable: Bool = false
    @State var selectedLesson: Lesson.ID?
    
    private let columns = [GridItem(.fixed(30)), GridItem(.flexible())]
    
    init(viewModel: TimetableViewModel, day: Binding<Day.ID>) {
        self.viewModel = viewModel
        self._day = day
    }
    
    var body: some View {
        VStack {
            if let timetable {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(Array(timetable.lessons.enumerated()), id: \.offset) { index, lesson in
                            NumberCircleView(number: index, color: lesson.color)
                            
                            LessonItemView(lesson: lesson)
                                .onTapGesture {
                                    selectedLesson = lesson.id
                                    showTimetable.toggle()
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
            } else {
                ScrollView {
                    Color.clear
                }
                .background(
                    placeholder
                )
            }
        }
        .refreshable {
            viewModel.fetchTimetable(date: store[day].date)
        }
        .onChange(of: selectedLesson) { newValue in
            
        }
        .popover(isPresented: $showTimetable) {
            if let lesson = timetable?.lessons.first(where: { selectedLesson == $0.id }) {
                LessonView(lesson: lesson)
            } else {
                placeholder
            }
        }
        .onAppear {
            viewModel.fetchTimetable(date: store[day].date)
        }
        .onChange(of: day) { newDay in
            viewModel.fetchTimetable(date: store[newDay].date)
        }
        .onReceive(viewModel.$timetable, perform: { newTimeTable in
            self.timetable = newTimeTable
        })
    }
    
    var placeholder: some View {
        Text("Расписание не найдено")
            .multilineTextAlignment(.center)
            .font(.title2)
            .foregroundColor(.secondary)
            .frame(maxHeight: .infinity, alignment: .center)
    }
}

struct TimetableView_Previews: PreviewProvider {
    static var previews: some View {
        let dayStore = DayStore()
        TimetableView(viewModel: TimetableViewModel(timetableStore: TimetableStore()), day: .constant(dayStore.tomorrow.id))
            .environmentObject(dayStore)
    }
}
