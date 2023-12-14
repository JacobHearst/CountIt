//
// Counter.swift
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Counter {
    @Attribute(.unique) let id: UUID
    @Attribute(.unique) let createdAt: Date

    var name: String
    var incrementStep: Int
    var interval: Interval
    var disallowSubtraction: Bool

    var red: Float
    var green: Float
    var blue: Float

    var color: Color {
        Color(red: Double(red), green: Double(green), blue: Double(blue))
    }

    var changeEventPredicate: Predicate<CounterChangeEvent> {
        let now = Date()
        switch interval {
        case .Never:
            return #Predicate { _ in true }
        case .Day:
            return #Predicate {
                $0.dayOfMonth == now.dayOfMonth
            }
        case .Week:
            return #Predicate { event in
                event.weekOfYear == now.weekOfYear &&
                event.yearForWeekOfYear == now.yearForWeekOfYear
            }
        case .Month:
            return #Predicate {
                $0.month == now.month && $0.year == now.year
            }
        case .Year:
            return #Predicate {
                $0.year == now.year
            }
        }
    }

    var count: Int

    @Relationship(deleteRule: .cascade, inverse: \CounterChangeEvent.counter)
    private(set) var history = [CounterChangeEvent]()

    init(
        name: String,
        incrementStep: Int = 1,
        createdAt: Date = Date(),
        count: Int = 0,
        id: UUID = UUID(),
        interval: Interval = .Never,
        colorComponents: Color.Resolved,
        disallowSubtraction: Bool = false
    ) {
        self.name = name
        self.incrementStep = incrementStep
        self.createdAt = createdAt
        self.count = count
        self.id = id
        self.interval = interval
        self.red = colorComponents.red
        self.green = colorComponents.green
        self.blue = colorComponents.blue
        self.disallowSubtraction = disallowSubtraction
    }

    enum Interval: String, CaseIterable, Codable {
        case Never, Day, Week, Month, Year
    }
}
