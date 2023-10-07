//
// CounterEditor.swift.swift
//

import SwiftUI

struct CounterEditor: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var increment = 1

    let counter: Counter?

    private var editorTitle: String {
        counter == nil ? "Add Counter" : "Edit Counter"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Required") {
                    TextField("Counter name", text: $name)
                    Stepper(value: $increment) {
                        HStack {
                            Text("Increment by:")
                            Spacer()
                            Text(increment.description)
                                .padding(.trailing)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }.disabled(name.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }.onAppear {
            if let counter {
                name = counter.name
                increment = counter.incrementStep
            }
        }
    }

    private func save() {
        if let counter {
            // Edit the animal.
            counter.name = name
            counter.incrementStep = increment
        } else {
            let newCounter = Counter(name: name, incrementStep: increment)
            modelContext.insert(newCounter)
        }
    }

}

#Preview {
    CounterEditor(counter: nil)
}
