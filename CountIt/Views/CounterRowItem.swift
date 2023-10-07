//
// CounterRowItem.swift
//

import SwiftUI

struct CounterRowItem: View {
    @Bindable var counter: Counter

    var body: some View {
        HStack {
            Button(action: counter.decrement) {
                Image(systemName: "minus")
                    .frame(width: 20, height: 20)
                    .help("Decrement the counter")
            }

            Spacer()

            VStack {
                Text(counter.name)
                Text(counter.count.description)
            }

            Spacer()

            Button(action: counter.increment) {
                Image(systemName: "plus")
                    .frame(width: 20, height: 20)
                    .help("Increment the counter")
            }
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    CounterRowItem(counter: Counter(name: "Test"))
}
