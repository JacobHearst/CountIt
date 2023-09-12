//
// CounterIntents.swift
//

import AppIntents
    
struct IncrementCounterIntent: AppIntent {
    static var title: LocalizedStringResource = "Increment Counter"
    @Parameter(title: "Name", optionsProvider: CounterOptionsProvider()) var name: String

    func perform() async throws -> some IntentResult & ReturnsValue<Int> {
        let provider = try CounterProvider()
        guard let counter = try provider.fetchCounters().first(where: { $0.name == name }) else {
            print("Couldn't find counter with name '\(name)'")
            return .result(value: 0)
        }

        counter.count += 1
        try provider.context.save()
        return .result(value: counter.count)
    }

    private final class CounterOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            try CounterProvider().fetchCounters().map { $0.name }
        }
    }
}
