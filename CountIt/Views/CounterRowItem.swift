//
// CounterRowItem.swift
//

import SwiftUI

struct CounterRowItem: View {
    @Bindable var counter: Counter

    var body: some View {
        HStack {
            Button {
                counter.count -= 1
            } label: {
                Image(systemName: "minus")
                    .frame(width: 20, height: 20)
            }

            Spacer()

            VStack {
                Text(counter.name)
                Text(counter.count.description)
            }

            Spacer()

            Button {
                counter.count += 1
            } label: {
                Image(systemName: "plus")
                    .frame(width: 20, height: 20)
            }
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    CounterRowItem(counter: Counter(name: "Test"))
}
