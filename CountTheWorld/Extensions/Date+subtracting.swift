//
// Date+subtracting.swift
//

import Foundation

extension Date {
    func subtracting(days: Int) -> Self {
        var copy = self
        copy.addTimeInterval(.days(days) * -1)
        return copy
    }

    func subtracting(weeks: Int) -> Self {
        self.subtracting(days: weeks * 7)
    }

    func subtracting(months: Int) -> Self {
        self.subtracting(days: Int(Double(months) * 30.4375))
    }

    func subtracting(years: Int) -> Self {
        self.subtracting(days: years * 365)
    }
}
