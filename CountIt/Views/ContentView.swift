//
// ContentView.swift
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var counters: [Counter]
    @State private var showCreateListAlert = false
    @State private var newCounterName = ""

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
                    Button {
                        showCreateListAlert = true
                    } label: {
                        Label("Create a counter", systemImage: "plus")
                    }
                }
            }
            .alert("Create a counter", isPresented: $showCreateListAlert) {
                TextField("Name", text: $newCounterName)
                Button("Create", action: addItem)
                Button("Cancel", role: .cancel) {
                    newCounterName = ""
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Counter(name: newCounterName)
            modelContext.insert(newItem)
        }

        newCounterName = ""
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(counters[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Counter.self, inMemory: true)
}
