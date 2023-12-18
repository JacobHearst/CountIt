//
// CounterHistory.swift
//

import Foundation

extension Counter {
    struct History: Codable {
        var events = [Event]()

        func events(for interval: Interval) -> [Event] {
            let components: [Calendar.Component] = switch interval {
            case .Never:
                []
            case .Day:
                [.day, .month, .year]
            case .Month:
                [.month, .year]
            case .Week:
                [.weekOfYear, .weekOfMonth, .yearForWeekOfYear]
            case .Year:
                [.year]
            }

            let now = Date()
            return events.filter { Calendar.current.componentsMatch(lhs: $0.timestamp, rhs: now, components: components) }
        }
    }
}

extension Counter.History {
    struct Event: Codable, Identifiable {
        var id: Date { timestamp }
        let change: Int
        let newTotal: Int
        let timestamp: Date

        init(timestamp: Date = Date(), newTotal: Int, change: Int) {
            self.timestamp = timestamp
            self.newTotal = newTotal
            self.change = change
        }
    }
}

extension [Counter.History.Event] {
    var sum: Int {
        reduce(0) { partialResult, event in
            partialResult + event.change
        }
    }
}
