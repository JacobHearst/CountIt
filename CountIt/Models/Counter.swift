//
// Counter.swift
//

import Foundation
import SwiftData

@Model
final class Counter {
    let id: UUID
    let timestamp: Date

    var name: String
    var incrementStep: Int

    private(set) var count: Int

    init(name: String, incrementStep: Int = 1, timestamp: Date = Date(), count: Int = 0, id: UUID = UUID()) {
        self.name = name
        self.incrementStep = incrementStep
        self.timestamp = timestamp
        self.count = count
        self.id = id
    }

    func increment() {
        count += incrementStep
    }

    func decrement() {
        count -= incrementStep
    }
}
