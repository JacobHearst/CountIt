//
// CounterEditor.swift.swift
//

import SwiftUI

struct CounterEditor: View {
    @Environment(\.self) private var environment
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var increment = 1
    @State private var interval: Counter.Interval = .Never
    @State private var color = Color.random()

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
                Section("Optional") {
                    Picker("Reset count every:", selection: $interval) {
                        ForEach(Counter.Interval.allCases, id: \.rawValue) {
                            Text($0.rawValue).tag($0)
                        }
                    }

                    ColorPicker("Counter color", selection: $color, supportsOpacity: false)
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
        }
        .onAppear {
            if let counter {
                name = counter.name
                increment = counter.incrementStep
                color = counter.color
                interval = counter.interval
            }
        }
    }

    private func save() {
        let colorComponents = color.resolve(in: environment)

        if let counter {
            // Edit the counter
            counter.name = name
            counter.incrementStep = increment
            counter.interval = interval
            counter.red = colorComponents.red
            counter.blue = colorComponents.blue
            counter.green = colorComponents.green
        } else {
            // Make a new counter
            let newCounter = Counter(name: name, incrementStep: increment, interval: interval, colorComponents: colorComponents)
            modelContext.insert(newCounter)
        }
    }

}

#Preview("Create new") {
    CounterEditor(counter: nil)
}
