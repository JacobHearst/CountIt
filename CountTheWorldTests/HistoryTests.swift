//
// CountTheWorldTests.swift
//

import XCTest
@testable import CountTheWorld

final class HistoryTests: XCTestCase {
    func testDayBuckets() throws {
        let today = Date()
        let yesterday = today.subtracting(days: 1)
        let twoDaysAgo = today.subtracting(days: 2)
        let threeDaysAgo = today.subtracting(days: 3)

        let bucket1Events: [Counter.History.Event] = [
            .init(timestamp: threeDaysAgo, newTotal: 1, change: 1),
            .init(timestamp: threeDaysAgo, newTotal: 2, change: 1),
            .init(timestamp: threeDaysAgo, newTotal: 3, change: 1)
        ]
        let bucket2Events: [Counter.History.Event] = [.init(timestamp: twoDaysAgo, newTotal: 1, change: 1)]
        let bucket3Events: [Counter.History.Event] = [
            .init(timestamp: yesterday, newTotal: 1, change: 1),
            .init(timestamp: yesterday, newTotal: 2, change: 1)
        ]
        let bucket4Events: [Counter.History.Event] = [
            .init(timestamp: today, newTotal: 2, change: 1),
            .init(timestamp: today, newTotal: 3, change: 1),
            .init(timestamp: today, newTotal: 4, change: 1),
            .init(timestamp: today, newTotal: 5, change: 1),
            .init(timestamp: today, newTotal: 6, change: 1)
        ]

        let events = bucket1Events + bucket2Events + bucket3Events + bucket4Events
        let history = Counter.History(events: events)

        // When
        let buckets = history.buckets(for: .Day)

        // Then
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withDay, .withMonth, .withYear, .withDashSeparatorInDate]

        let expBucket1Label = formatter.string(from: bucket1Events[0].timestamp)
        let expBucket2Label = formatter.string(from: bucket2Events[0].timestamp)
        let expBucket3Label = formatter.string(from: bucket3Events[0].timestamp)
        let expBucket4Label = formatter.string(from: bucket4Events[0].timestamp)
        let expectedBuckets: [EventBucket] = [
            EventBucket(label: expBucket1Label, events: bucket1Events),
            EventBucket(label: expBucket2Label, events: bucket2Events),
            EventBucket(label: expBucket3Label, events: bucket3Events),
            EventBucket(label: expBucket4Label, events: bucket4Events),
        ]

        XCTAssertEqual(buckets, expectedBuckets)
    }

    func testWeekBuckets() throws {
        let today = Date()
        let yesterday = today.subtracting(weeks: 1)
        let twoDaysAgo = today.subtracting(weeks: 2)
        let threeDaysAgo = today.subtracting(weeks: 3)

        let bucket1Events: [Counter.History.Event] = [
            .init(timestamp: threeDaysAgo, newTotal: 1, change: 1),
            .init(timestamp: threeDaysAgo, newTotal: 2, change: 1),
            .init(timestamp: threeDaysAgo, newTotal: 3, change: 1)
        ]
        let bucket2Events: [Counter.History.Event] = [.init(timestamp: twoDaysAgo, newTotal: 1, change: 1)]
        let bucket3Events: [Counter.History.Event] = [
            .init(timestamp: yesterday, newTotal: 1, change: 1),
            .init(timestamp: yesterday, newTotal: 2, change: 1)
        ]
        let bucket4Events: [Counter.History.Event] = [
            .init(timestamp: today, newTotal: 2, change: 1),
            .init(timestamp: today, newTotal: 3, change: 1),
            .init(timestamp: today, newTotal: 4, change: 1),
            .init(timestamp: today, newTotal: 5, change: 1),
            .init(timestamp: today, newTotal: 6, change: 1)
        ]

        let events = bucket1Events + bucket2Events + bucket3Events + bucket4Events
        let history = Counter.History(events: events)

        // When
        let buckets = history.buckets(for: .Week)

        // Then
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withYear, .withWeekOfYear, .withDashSeparatorInDate]

        let expBucket1Label = formatter.string(from: bucket1Events[0].timestamp)
        let expBucket2Label = formatter.string(from: bucket2Events[0].timestamp)
        let expBucket3Label = formatter.string(from: bucket3Events[0].timestamp)
        let expBucket4Label = formatter.string(from: bucket4Events[0].timestamp)
        let expectedBuckets: [EventBucket] = [
            EventBucket(label: expBucket1Label, events: bucket1Events),
            EventBucket(label: expBucket2Label, events: bucket2Events),
            EventBucket(label: expBucket3Label, events: bucket3Events),
            EventBucket(label: expBucket4Label, events: bucket4Events),
        ]

        XCTAssertEqual(buckets, expectedBuckets)
    }

    func testMonthBuckets() throws {
        let today = Date()
        let yesterday = today.subtracting(months: 1)
        let twoDaysAgo = today.subtracting(months: 2)
        let threeDaysAgo = today.subtracting(months: 3)

        let bucket1Events: [Counter.History.Event] = [
            .init(timestamp: threeDaysAgo, newTotal: 1, change: 1),
            .init(timestamp: threeDaysAgo, newTotal: 2, change: 1),
            .init(timestamp: threeDaysAgo, newTotal: 3, change: 1)
        ]
        let bucket2Events: [Counter.History.Event] = [.init(timestamp: twoDaysAgo, newTotal: 1, change: 1)]
        let bucket3Events: [Counter.History.Event] = [
            .init(timestamp: yesterday, newTotal: 1, change: 1),
            .init(timestamp: yesterday, newTotal: 2, change: 1)
        ]
        let bucket4Events: [Counter.History.Event] = [
            .init(timestamp: today, newTotal: 2, change: 1),
            .init(timestamp: today, newTotal: 3, change: 1),
            .init(timestamp: today, newTotal: 4, change: 1),
            .init(timestamp: today, newTotal: 5, change: 1),
            .init(timestamp: today, newTotal: 6, change: 1)
        ]

        let events = bucket1Events + bucket2Events + bucket3Events + bucket4Events
        let history = Counter.History(events: events)

        // When
        let buckets = history.buckets(for: .Month)

        // Then
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withYear, .withMonth, .withDashSeparatorInDate]

        let expBucket1Label = formatter.string(from: bucket1Events[0].timestamp)
        let expBucket2Label = formatter.string(from: bucket2Events[0].timestamp)
        let expBucket3Label = formatter.string(from: bucket3Events[0].timestamp)
        let expBucket4Label = formatter.string(from: bucket4Events[0].timestamp)
        let expectedBuckets: [EventBucket] = [
            EventBucket(label: expBucket1Label, events: bucket1Events),
            EventBucket(label: expBucket2Label, events: bucket2Events),
            EventBucket(label: expBucket3Label, events: bucket3Events),
            EventBucket(label: expBucket4Label, events: bucket4Events),
        ]

        XCTAssertEqual(buckets, expectedBuckets)
    }

    func testYearBuckets() throws {
        let today = Date()
        let yesterday = today.subtracting(years: 1)
        let twoDaysAgo = today.subtracting(years: 2)
        let threeDaysAgo = today.subtracting(years: 3)

        let bucket1Events: [Counter.History.Event] = [
            .init(timestamp: threeDaysAgo, newTotal: 1, change: 1),
            .init(timestamp: threeDaysAgo, newTotal: 2, change: 1),
            .init(timestamp: threeDaysAgo, newTotal: 3, change: 1)
        ]
        let bucket2Events: [Counter.History.Event] = [.init(timestamp: twoDaysAgo, newTotal: 1, change: 1)]
        let bucket3Events: [Counter.History.Event] = [
            .init(timestamp: yesterday, newTotal: 1, change: 1),
            .init(timestamp: yesterday, newTotal: 2, change: 1)
        ]
        let bucket4Events: [Counter.History.Event] = [
            .init(timestamp: today, newTotal: 2, change: 1),
            .init(timestamp: today, newTotal: 3, change: 1),
            .init(timestamp: today, newTotal: 4, change: 1),
            .init(timestamp: today, newTotal: 5, change: 1),
            .init(timestamp: today, newTotal: 6, change: 1)
        ]

        let events = bucket1Events + bucket2Events + bucket3Events + bucket4Events
        let history = Counter.History(events: events)

        // When
        let buckets = history.buckets(for: .Year)

        // Then
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withYear, .withDashSeparatorInDate]

        let expBucket1Label = formatter.string(from: bucket1Events[0].timestamp)
        let expBucket2Label = formatter.string(from: bucket2Events[0].timestamp)
        let expBucket3Label = formatter.string(from: bucket3Events[0].timestamp)
        let expBucket4Label = formatter.string(from: bucket4Events[0].timestamp)
        let expectedBuckets: [EventBucket] = [
            EventBucket(label: expBucket1Label, events: bucket1Events),
            EventBucket(label: expBucket2Label, events: bucket2Events),
            EventBucket(label: expBucket3Label, events: bucket3Events),
            EventBucket(label: expBucket4Label, events: bucket4Events),
        ]

        XCTAssertEqual(buckets, expectedBuckets)
    }
}
