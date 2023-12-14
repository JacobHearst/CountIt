//
// CounterRowItem.swift
//

import SwiftUI
import SwiftData

struct CounterRow: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var counter: Counter
    private var counterEvents: Query<Counter.ChangeEvent, [Counter.ChangeEvent]>
    private let foregroundColor: Color

    init(counter: Counter) {
        self.counter = counter
        self.counterEvents = Query(filter: counter.changeEventPredicate)
        foregroundColor = counter.color.isDark ? .white : .black
    }

    var body: some View {
        Group {
            GeometryReader { geometry in
                HStack {
                    if !counter.disallowSubtraction {
                        Image(systemName: "minus")
                            .help("Decrement the counter")
                    }

                    Spacer()

                    VStack {
                        Text(counter.name)
                            .font(.headline)
                        Text(counter.count.description)
                    }

                    Spacer()

                    if !counter.disallowSubtraction {
                        Image(systemName: "plus")
                            .help("Increment the counter")
                    }
                }
                .contentShape(RoundedRectangle(cornerRadius: 5))
                .foregroundStyle(foregroundColor)
                .onTapGesture {
                    let direction: Counter.IncrementDirection = $0.x <= geometry.size.width / 2 ? .down : .up
                    increment(direction: direction)
                }
            }
        }
        .listRowBackground(counter.color)
        .padding(20)
        .padding(.bottom)
    }

    private func increment(direction: Counter.IncrementDirection) {
        switch direction {
        case .up:
            counter.count += counter.incrementStep
        case .down:
            guard !counter.disallowSubtraction else { return }
            counter.count -= counter.incrementStep
        }

        modelContext.insert(Counter.ChangeEvent(counter: counter, newValue: counter.count))
    }
}

#Preview {
    CounterRow(counter: Counter(name: "Test", colorComponents: Color.red.resolve(in: .init())))
}
