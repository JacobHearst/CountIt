//
// ContentView.swift
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var counters: [Counter]
    @State private var showCounterEditor = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(counters) { counter in
                    CounterRowItem(counter: counter)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    AddCounterButton(isActive: $showCounterEditor)
                }
            }
            .sheet(isPresented: $showCounterEditor) {
                CounterEditor(counter: nil)
            }
            .overlay {
                if counters.isEmpty {
                    ContentUnavailableView {
                        Label("No counters found", systemImage: "questionmark.circle")
                    } description: {
                        AddCounterButton(isActive: $showCounterEditor)
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

#Preview {
    ContentView()
        .modelContainer(for: Counter.self, inMemory: true)
}
