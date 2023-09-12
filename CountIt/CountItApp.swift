//
// CountItApp.swift
//

import SwiftUI
import SwiftData

@main
struct CountItApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Counter.self)
    }
}
