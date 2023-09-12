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
            blue: .random(in: 0...1),
            opacity: .random(in: 0...1)
        )
    }
}
