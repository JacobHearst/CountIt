//
// CounterProvider.swift
//

import Foundation
import SwiftData

final class CounterProvider {
    let context: ModelContext

    init() throws {
        let container = try ModelContainer(for: Counter.self)
        context = ModelContext(container)
    }

    func fetchCounters() throws -> [Counter] {
        try context.fetch(FetchDescriptor<Counter>())
    }
}
