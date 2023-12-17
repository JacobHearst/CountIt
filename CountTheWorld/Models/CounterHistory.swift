//
// CounterHistory.swift
//

import Foundation

extension Counter {
    struct History: Codable {
        var events = [Event]()

        mutating func record(value: Int) {
            events.append(Event(newValue: value))
        }

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
        let newValue: Int
        let timestamp: Date

        init(timestamp: Date = Date(), newValue: Int) {
            self.timestamp = timestamp
            self.newValue = newValue
        }
    }
}
