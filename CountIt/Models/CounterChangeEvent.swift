//
// CounterChangeEvent.swift
//

import Foundation
import SwiftData

@Model
final class CounterChangeEvent {
    unowned let counter: Counter
    let newValue: Int

    let timestamp: Date
    var dayOfMonth: Int { timestamp.dayOfMonth }
    var weekOfYear: Int { timestamp.weekOfYear }
    var month: Int { timestamp.month }
    var year: Int { timestamp.year }
    var yearForWeekOfYear: Int { timestamp.yearForWeekOfYear }

    init(counter: Counter, timestamp: Date = Date(), newValue: Int) {
        self.counter = counter
        self.timestamp = timestamp
        self.newValue = newValue
    }
}
