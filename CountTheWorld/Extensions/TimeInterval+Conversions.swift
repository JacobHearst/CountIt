//
// TimeInterval+Conversions.swift
//

import Foundation

extension TimeInterval {
    static let oneHour: Self = 60 * 60
    static let oneDay: Self = oneHour * 24
    static let oneWeek: Self = oneDay * 7
    static let oneMonth: Self = oneDay * 30
    static let oneYear: Self = oneMonth * 12

    static func days(_ n: Int) -> TimeInterval {
        oneDay * Double(n)
    }
}
