//
//  MainApp.swift
//  Contacts
//

import SwiftUI

@main
struct MainApp: App {
    @StateObject private var habitStore = HabitStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(habitStore)
        }
    }
}
