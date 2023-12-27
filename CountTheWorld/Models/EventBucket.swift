//
// EventBucket.swift
//

import Foundation

struct EventBucket: Identifiable, Equatable, Codable {
    var id: String { label }
    let label: String
    let events: Counter.History
    let value: Int

    /// The date of the earliest event in this bucket
    var lowerBound: Date {
        events.first!.timestamp
    }

    /// The date of the latest event in this bucket
    var upperBound: Date {
        events.last!.timestamp
    }

    var counterTotal: Int {
        events.last!.newTotal
    }

    init?(label: String, events: Counter.History) {
        guard !events.isEmpty else { return nil }

        self.label = label
        self.events = events
        self.value = events.sum
    }

    static func == (lhs: EventBucket, rhs: EventBucket) -> Bool {
        lhs.label == rhs.label && lhs.value == rhs.value && lhs.events == rhs.events
    }
}

extension EventBucket {
    enum Interval {
        case day, week, month, year

        var calendarComponent: Calendar.Component {
            switch self {
            case .day: .day
            case .week: .weekOfYear
            case .month: .month
            case .year: .year
            }
        }

        var advanceBy: TimeInterval {
            switch self {
            case .day: .oneDay
            case .week: .oneWeek
            case .month: .oneMonth
            case .year: .oneYear
            }
        }

        var isoFormatter: ISO8601DateFormatter {
            switch self {
            case .day:
                    .withIdentifiableDay
            case .week:
                    .withIdentifiableWeek
            case .month:
                    .withIdentifiableMonth
            case .year:
                    .withIdentifiableYear
            }
        }
    }
}
