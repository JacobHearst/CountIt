//
// CountTheWorldApp.swift
//

import SwiftUI
import SwiftData

@main
struct CountTheWorldApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Counter.self)
        .modelContainer(for: Counter.ChangeEvent.self)
    }
}
