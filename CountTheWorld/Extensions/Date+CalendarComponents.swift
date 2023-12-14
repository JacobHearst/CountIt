//
// Date+CalendarComponents.swift
//

import Foundation

extension Date {
    var dayOfMonth: Int {
        Calendar.current.component(.day, from: self)
    }

    var weekOfYear: Int {
        Calendar.current.component(.weekOfYear, from: self)
    }

    var month: Int {
        Calendar.current.component(.month, from: self)
    }

    var year: Int {
        Calendar.current.component(.year, from: self)
    }

    var yearForWeekOfYear: Int {
        Calendar.current.component(.yearForWeekOfYear, from: self)
    }
}
