//
//  Day.swift
//  CalendarStudy
//
//  Created by Deonte Kilgore on 4/30/24.
//

import SwiftData
import Foundation

@Model class Day {
    var date: Date
    var didStudy: Bool
    
    init(date: Date, didStudy: Bool) {
        self.date = date
        self.didStudy = didStudy
    }
}
