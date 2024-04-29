//
//  CalendarStudyApp.swift
//  CalendarStudy
//
//  Created by Deonte Kilgore on 4/29/24.
//

import SwiftUI

@main
struct CalendarStudyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
