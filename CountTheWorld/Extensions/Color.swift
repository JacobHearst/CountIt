//
// Color+random.swift
//

import Foundation
import SwiftUI

extension Color {
    static func random() -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }

    var isDark: Bool {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        guard UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: nil) else {
            return false
        }

        let lum = 0.2126 * red + 0.7152 * green + 0.0722 * blue
        return lum < 0.5
    }

    var foregroundColor: Color {
        isDark ? .white : .black
    }
}

extension Color.Resolved {
    static func random() -> Self {
        Self(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
