//
// CounterRowItem.swift
//

import SwiftUI
import SwiftData

struct CounterRow: View {
    @Environment(\.editMode) var editMode
    @Environment(\.modelContext) var modelContext
    var counter: Counter
    var onSelect: () -> Void

    var body: some View {
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
                    Text(counter.eventsInInterval.sum.description)
                }

                Spacer()

                if !counter.disallowSubtraction {
                    Image(systemName: "plus")
                        .help("Increment the counter")
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: 5))
            .foregroundStyle(counter.color.foregroundColor)
            .onTapGesture { location in
                guard editMode?.wrappedValue == .inactive else {
                    onSelect()
                    return
                }

                if location.x <= geometry.size.width / 2 {
                    counter.decrement()
                } else {
                    counter.increment()
                }
            }
        }
        .listRowBackground(counter.color)
        .padding(20)
        .padding(.bottom)
    }
}
