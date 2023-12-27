//
// HistoryView.swift
//

import SwiftUI
import Charts
import SwiftData

struct HistoryView: View {
    @State private var listMode = false

    var history: [Counter.History.Event]
    var buckets: [EventBucket]

    var body: some View {
        Group {
            if listMode {
                List(history) { event in
                    Text("\(label(date: event.timestamp)): \(event.newTotal)")
                }
            } else {
                Chart(buckets) { bucket in
                    BarMark(x: .value("Date", bucket.label), y: .value("Count", bucket.value))
                }.padding()
            }
        }
        .navigationTitle("History")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    listMode.toggle()
                } label: {
                    Image(systemName: listMode ?  "chart.bar.fill" : "list.bullet")
                }
            }
        }
    }

    func label(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview("Multiple days") {
    let today = Date()
    let yesterday = today.subtracting(days: 1)
    let twoDaysAgo = today.subtracting(days: 2)
    let threeDaysAgo = today.subtracting(days: 3)

    let events: [Counter.History.Event] = [
        .init(timestamp: threeDaysAgo, newTotal: 1, change: 1),
        .init(timestamp: threeDaysAgo, newTotal: 2, change: 1),
        .init(timestamp: threeDaysAgo, newTotal: 3, change: 1),
        .init(timestamp: twoDaysAgo, newTotal: 1, change: 1),
        .init(timestamp: yesterday, newTotal: 1, change: 1),
        .init(timestamp: yesterday, newTotal: 2, change: 1),
        .init(timestamp: today, newTotal: 2, change: 1),
        .init(timestamp: today, newTotal: 3, change: 1),
        .init(timestamp: today, newTotal: 4, change: 1),
        .init(timestamp: today, newTotal: 5, change: 1),
        .init(timestamp: today, newTotal: 6, change: 1),
    ]

    let history = Counter.History(events: events)
    let buckets = history.buckets(for: .day)

    return HistoryView(history: history.events, buckets: buckets)
}

#Preview("One day") {
    let today = Date()

    let events: [Counter.History.Event] = [
        .init(timestamp: today, newTotal: 2, change: 1),
        .init(timestamp: today, newTotal: 3, change: 1),
        .init(timestamp: today, newTotal: 4, change: 1),
        .init(timestamp: today, newTotal: 5, change: 1),
        .init(timestamp: today, newTotal: 6, change: 1),
    ]

    let history = Counter.History(events: events)
    let buckets = history.buckets(for: .day)

    return HistoryView(history: history.events, buckets: buckets)
}

#Preview("One week") {
    let today = Date()
    let yesterday = today.subtracting(weeks: 1)
    let twoDaysAgo = today.subtracting(weeks: 2)
    let threeDaysAgo = today.subtracting(weeks: 3)

    let events: [Counter.History.Event] = [
        .init(timestamp: threeDaysAgo, newTotal: 1, change: 1),
        .init(timestamp: threeDaysAgo, newTotal: 2, change: 1),
        .init(timestamp: threeDaysAgo, newTotal: 3, change: 1),
        .init(timestamp: twoDaysAgo, newTotal: 1, change: 1),
        .init(timestamp: yesterday, newTotal: 1, change: 1),
        .init(timestamp: yesterday, newTotal: 2, change: 1),
        .init(timestamp: today, newTotal: 2, change: 1),
        .init(timestamp: today, newTotal: 3, change: 1),
        .init(timestamp: today, newTotal: 4, change: 1),
        .init(timestamp: today, newTotal: 5, change: 1),
        .init(timestamp: today, newTotal: 6, change: 1),
    ]

    let history = Counter.History(events: events)
    let buckets = history.buckets(for: .week)

    return HistoryView(history: history.events, buckets: buckets)
}

#Preview("One week+gap") {
    let today = Date()
    let threeDaysAgo = today.subtracting(weeks: 3)

    let events: [Counter.History.Event] = [
        .init(timestamp: threeDaysAgo, newTotal: 1, change: 1),
        .init(timestamp: threeDaysAgo, newTotal: 2, change: 1),
        .init(timestamp: threeDaysAgo, newTotal: 3, change: 1),
        .init(timestamp: today, newTotal: 2, change: 1),
        .init(timestamp: today, newTotal: 3, change: 1),
        .init(timestamp: today, newTotal: 4, change: 1),
        .init(timestamp: today, newTotal: 5, change: 1),
        .init(timestamp: today, newTotal: 6, change: 1),
    ]

    let history = Counter.History(events: events)
    let buckets = history.buckets(for: .week)

    return HistoryView(history: history.events, buckets: buckets)
}
