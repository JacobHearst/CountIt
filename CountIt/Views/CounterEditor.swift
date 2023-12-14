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
    @State private var disallowSubtraction = false
    @State private var counterValue = 0

    let counter: Counter?

    private var editorTitle: String {
        counter == nil ? "Add Counter" : "Edit Counter"
    }

    private var counterValueLabel: String {
        counter == nil ? "Initial value": "Current value"
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
                    } onEditingChanged: { _ in
                        clampInterval()
                    }

                    ColorPicker("Counter color", selection: $color, supportsOpacity: false)
                }
                Section("Optional") {
                    Stepper(value: $counterValue, step: increment) {
                        HStack {
                            Text(counterValueLabel)
                            Spacer()
                            Text(counterValue.description)
                                .padding(.trailing)
                        }
                    }
                    Picker("Reset count every:", selection: $interval) {
                        ForEach(Counter.Interval.allCases, id: \.rawValue) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    Toggle("Disallow subtraction", isOn: $disallowSubtraction)
                }
            }
            .onChange(of: disallowSubtraction, clampInterval)
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
                counterValue = counter.count
                disallowSubtraction = counter.disallowSubtraction
            }
        }
    }

    private func clampInterval() {
        increment = max(1, increment)
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
            counter.count = counterValue
            counter.disallowSubtraction = disallowSubtraction
        } else {
            // Make a new counter
            let newCounter = Counter(
                name: name,
                incrementStep: increment,
                count: counterValue,
                interval: interval,
                colorComponents: colorComponents,
                disallowSubtraction: disallowSubtraction
            )
            modelContext.insert(newCounter)
        }
    }

}

#Preview("Create new") {
    CounterEditor(counter: nil)
}
