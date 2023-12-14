//
// HistoryView.swift
//

import SwiftUI
import Charts
import SwiftData

struct HistoryView: View {
    @State private var listMode = false

    private var counter: Counter
    private var timeline: [Counter.ChangeEvent]

    init(counter: Counter) {
        self.counter = counter
        timeline = counter.history.sorted { $0.timestamp < $1.timestamp }
    }

    var body: some View {
        Group {
            if listMode {
                List(timeline) { event in
                    Text("\(event.timestamp): \(event.newValue)")
                }
            } else {
                Chart(timeline) { event in
                    LineMark(x: .value("Date", event.timestamp), y: .value("Count", event.newValue))
                }
            }
        }
        .navigationTitle("History")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    listMode.toggle()
                } label: {
                    Image(systemName: listMode ?  "chart.xyaxis.line" : "list.bullet")
                }
            }
        }
    }
}
