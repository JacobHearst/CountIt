//
// Counter.swift
//

import Foundation
import SwiftData

@Model
final class Counter {
    var id: UUID
    var timestamp: Date
    var count: Int
    var name: String

    init(timestamp: Date = Date(), count: Int = 0, name: String, id: UUID = UUID()) {
        self.timestamp = timestamp
        self.count = count
        self.name = name
        self.id = id
    }
}
