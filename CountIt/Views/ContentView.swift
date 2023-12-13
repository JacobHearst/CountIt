//
// ContentView.swift
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var counters: [Counter]
    @State private var selectedCounter: Counter?
    @State private var showCounterCreator = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(counters) { counter in
                    CounterRowItem(counter: counter)
                        .contextMenu {
                            Button("Edit") {
                                selectedCounter = counter
                            }
                        }
                }
                .onDelete(perform: deleteItems)
            }
            .listRowSpacing(10)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    AddCounterButton(isActive: $showCounterCreator)
                }
            }
            .sheet(item: $selectedCounter) {
                CounterEditor(counter: $0)
            }
            .sheet(isPresented: $showCounterCreator) {
                CounterEditor(counter: nil)
            }
            .overlay {
                if counters.isEmpty {
                    ContentUnavailableView {
                        Label("No counters found", systemImage: "questionmark.circle")
                    } description: {
                        AddCounterButton(isActive: $showCounterCreator)
                    }
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(counters[index])
            }
        }
    }

    private struct AddCounterButton: View {
        @Binding var isActive: Bool

        var body: some View {
            Button {
                isActive = true
            } label: {
                Label("Create a counter", systemImage: "plus")
                    .help("Create a counter")
            }
        }
    }
}

#Preview("Zero state") {
    ContentView()
        .modelContainer(for: Counter.self, inMemory: true)
}

#Preview("1 counter") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Counter.self, configurations: config)
    container.mainContext.insert(Counter(name: "Test counter", colorComponents: .random()))

    return ContentView()
        .modelContainer(container)
}

#Preview("2 counters") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Counter.self, configurations: config)

    for i in 0..<3 {
        let counter = Counter(name: i.description, colorComponents: .random())
        container.mainContext.insert(counter)
    }

    return ContentView()
        .modelContainer(container)
}

#Preview("3 counters") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Counter.self, configurations: config)

    for i in 0..<4 {
        let counter = Counter(name: i.description, colorComponents: .random())
        container.mainContext.insert(counter)
    }

    return ContentView()
        .modelContainer(container)
}

#Preview("Lots of counters") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Counter.self, configurations: config)

    for i in 0..<50 {
        let counter = Counter(name: i.description, colorComponents: .random())
        container.mainContext.insert(counter)
    }

    return ContentView()
        .modelContainer(container)
}
