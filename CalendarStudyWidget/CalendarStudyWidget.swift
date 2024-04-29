//
//  CalendarStudyWidget.swift
//  CalendarStudyWidget
//
//  Created by Deonte Kilgore on 4/29/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct CalendarStudyWidgetEntryView : View {
    var entry: Provider.Entry
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    var body: some View {
        HStack {
            VStack {
                Text("31")
                    .font(.system(size: 70, design: .rounded))
                    .bold()
                    .foregroundStyle(Color.green)
                Text("Day Streak")
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
            }
            
            VStack {
                CalendarHeaderView(font: .caption)
                
                LazyVGrid(columns: columns, spacing: 7) {
                    ForEach(0..<31) { _ in
                       Text("31")
                            .font(.caption2)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.secondary)
                            .background(
                                Circle()
                                    .foregroundStyle(.green.opacity(0.3))
                                    .scaleEffect(1.5)
                            )
                    }
                }
            }
            .padding(.leading, 6)
        }.padding()
    }
}

struct CalendarStudyWidget: Widget {
    let kind: String = "CalendarStudyWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            CalendarStudyWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemMedium])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    CalendarStudyWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
