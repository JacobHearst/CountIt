//
// HistoryView.swift
//

import SwiftUI
import Charts
import SwiftData

struct HistoryView: View {
    @State private var listMode = false

    var history: Counter.History

    var body: some View {
        Group {
            if listMode {
                List(history.events) { event in
                    Text("\(event.timestamp): \(event.newValue)")
                }
            } else {
                Chart(history.events) { event in
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
