//
//  CalendarView.swift
//  CalendarStudy
//
//  Created by Deonte Kilgore on 4/29/24.
//

import SwiftUI
import SwiftData
import WidgetKit

struct CalendarView: View {
    static var startDate: Date { .now.startOfCalanderWithPrefixDays }
    static var endDate: Date { .now.endOfMonth }
    
    @Environment(\.modelContext) private var context
    
    @Query(filter: #Predicate<Day> { $0.date > startDate && $0.date < endDate }, sort: \Day.date)
    var days: [Day]
    
    private let calendarColor: Color = .green
    
    var body: some View {
        NavigationView {
            VStack {
                CalendarHeaderView()
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                    ForEach(days) { day in
                        if day.date.monthInt != Date().monthInt {
                            Text(" ")
                        } else {
                            Text(day.date.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(day.didStudy ? calendarColor : .secondary)
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background(
                                    Circle()
                                        .foregroundStyle(calendarColor.opacity(day.didStudy ? 0.3 : 0.0))
                                )
                                .onTapGesture {
                                    if day.date.dayInt <= Date().dayInt {
                                        day.didStudy.toggle()
                                        WidgetCenter.shared.reloadTimelines(ofKind: "SwiftCalWidget")
                                    } else {
                                        print("Can't study in the future!!")
                                    }
                                }

//                                .onTapGesture {
//                                    if day.date!.dayInt <= Date().dayInt {
//                                        day.didStudy.toggle()
//                                        do  {
//                                            try viewContext.save()
//                                            print("👆 \(day.date!.dayInt) now studied.")
//                                        } catch {
//                                            print("Failed to save context")
//                                        }
//                                    } else {
//                                        print("You can't study in the future!")
//                                    }
//                                }
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle(Date().formatted(.dateTime.month(.wide)))
            .padding()
            .onAppear {
                if days.isEmpty {
                    createMonthDays(for: .now.startOfPreviousMonth)
                    createMonthDays(for: .now)
                } else if days.count < 10 { // is this ONLY the prefix days
                    createMonthDays(for: .now)
                }
            }
        }
    }
    
    func createMonthDays(for date: Date) {
        for dayOffset in 0..<date.numberOfDaysInMonth {
            let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: date.startOfMonth)!
            let newDay = Day(date: date, didStudy: false)
            context.insert(newDay)
        }
//        for dayOffset in 0..<date.numberOfDaysInMonth {
//            let newDay = Day(context: viewContext)
//            newDay.date = Calendar.current.date(byAdding: .day, value: dayOffset, to: date.startOfMonth)
//            newDay.didStudy = false
//        }
//        
//        do {
//            try viewContext.save()
//            print("✅ \(date.monthFullName) days created.")
//        } catch {
//            print("Failed to save context.")
//        }
    }
    
}


#Preview {
    CalendarView()
}
