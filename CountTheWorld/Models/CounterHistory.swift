//
// CounterHistory.swift
//

import Foundation

extension Counter {
    struct History: Codable {
        var events = [Event]()

        var range: TimeInterval {
            guard
                let start = events.first?.timestamp.timeIntervalSince1970,
                let end = events.last?.timestamp.timeIntervalSince1970
            else {
                return 0
            }

            return end - start
        }

        func events(for interval: Interval) -> [Event] {
            let calendarMatchingComponents: [Calendar.Component] = switch interval {
            case .Never:
                []
            case .Day:
                [.day, .month, .year]
            case .Month:
                [.month, .year]
            case .Week:
                [.weekOfYear, .weekOfMonth, .yearForWeekOfYear]
            case .Year:
                [.year]
            }

            let now = Date()
            return events.filter {
                Calendar.current.componentsMatch(lhs: $0.timestamp, rhs: now, components: calendarMatchingComponents)
            }
        }

        func buckets(for interval: EventBucket.Interval) -> [EventBucket] {
            let bucketGroups = Dictionary(grouping: events, by: { interval.isoFormatter.string(from: $0.timestamp) })
            let buckets = bucketGroups.compactMap { key, value in
                EventBucket(label: key, events: value)
            }.sorted { lhs, rhs in
                lhs.lowerBound < rhs.lowerBound
            }

            return resample(buckets: buckets, by: interval)
        }

        private func resample(buckets: [EventBucket], by interval: EventBucket.Interval) -> [EventBucket] {
            func index(of bucket: EventBucket) -> Int {
                Calendar.current.component(interval.calendarComponent, from: bucket.lowerBound)
            }

            var result = [EventBucket]()

            var lastBucket = buckets.first
            for bucket in buckets {
                defer {
                    result.append(bucket)
                    lastBucket = bucket
                }

                while let last = lastBucket, index(of: bucket) - index(of: last) > 1 {
                    let fillerEvent = Event(
                        timestamp: Calendar.current.startOfDay(for: last.lowerBound.addingTimeInterval(interval.advanceBy)),
                        newTotal: last.value,
                        change: 0
                    )

                    let newBucket = EventBucket(label: "", events: [fillerEvent])
                    guard let newBucket else { continue }
                    result.append(newBucket)
                    lastBucket = newBucket
                }
            }

            return result
        }
    }
}

extension Counter.History {
    struct Event: Codable, Identifiable, Equatable {
        var id: Date { timestamp }
        let change: Int
        let newTotal: Int
        let timestamp: Date

        init(timestamp: Date, newTotal: Int, change: Int) {
            self.timestamp = timestamp
            self.newTotal = newTotal
            self.change = change
        }
    }
}

extension [Counter.History.Event] {
    var sum: Int {
        reduce(0) { partialResult, event in
            partialResult + event.change
        }
    }
}
