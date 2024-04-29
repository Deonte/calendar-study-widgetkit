//
//  CalendarHeaderView.swift
//  CalendarStudy
//
//  Created by Deonte Kilgore on 4/29/24.
//

import SwiftUI

struct CalendarHeaderView: View {
    var font: Font = .body
    
    private let calendarColor: Color = .green
    let daysOfWeek = ["Su", "M", "T", "W", "Th", "F", "S"]

    var body: some View {
        HStack {
            ForEach(daysOfWeek, id: \.self) { dayOfWeek in
                Text(dayOfWeek)
                    .font(font)
                    .fontWeight(.black)
                    .foregroundStyle(calendarColor)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

#Preview {
    CalendarHeaderView()
}
