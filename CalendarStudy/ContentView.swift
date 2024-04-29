//
//  ContentView.swift
//  CalendarStudy
//
//  Created by Deonte Kilgore on 4/29/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Day.date, ascending: true)],
        animation: .default)
    private var days: FetchedResults<Day>
    
    let daysOfWeek = ["Su", "M", "T", "W", "Th", "F", "S"]
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ForEach(daysOfWeek, id: \.self) { dayOfWeek in
                        Text(dayOfWeek)
                            .fontWeight(.black)
                            .foregroundStyle(Color.green)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                }
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                    ForEach(days) { day in
                        Text(day.date!.formatted(.dateTime.day()))
                            .fontWeight(.bold)
                            .foregroundStyle(day.didStudy ? .green : .secondary)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundStyle(Color.green.opacity(day.didStudy ? 0.3 : 0.0))
                            )
                    }
                }
                Spacer()
            }
            .navigationTitle(Date().formatted(.dateTime.month(.wide)))
            .padding()
        }
    }
    
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
