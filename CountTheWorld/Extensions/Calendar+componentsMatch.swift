//
// Calendar+componentsMatch.swift
//

import Foundation

extension Calendar {
    func componentsMatch(lhs: Date, rhs: Date, components: [Component]) -> Bool {
        components.allSatisfy { component in
            Calendar.current.component(component, from: lhs) == Calendar.current.component(component, from: rhs)
        }
    }
}
