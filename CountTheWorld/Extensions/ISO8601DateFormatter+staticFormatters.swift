//
// ISO8601DateFormatter+staticFormatters.swift
//

import Foundation

extension ISO8601DateFormatter {
    static let defaultFormatter = ISO8601DateFormatter()

    static let withIdentifiableDay = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withDay, .withMonth, .withYear]
        return formatter
    }()

    static let withIdentifiableWeek = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withWeekOfYear, .withYear]
        return formatter
    }()

    static let withIdentifiableMonth = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withMonth, .withYear]
        return formatter
    }()

    static let withIdentifiableYear = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withYear]
        return formatter
    }()
}
