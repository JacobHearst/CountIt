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
    var count: Int
    var incrementStep: Int
    var interval: Interval
    var disallowSubtraction: Bool
    var red: Float
    var green: Float
    var blue: Float
    private(set) var history: History

    var color: Color {
        Color(red: Double(red), green: Double(green), blue: Double(blue))
    }

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
        self.history = History()
    }

    func increment() {
        count += incrementStep
        history.record(value: count)
    }

    func decrement() {
        guard !disallowSubtraction else { return }
        count -= incrementStep
        history.record(value: count)
    }

    enum Interval: String, CaseIterable, Codable {
        case Never, Day, Week, Month, Year
    }
}
