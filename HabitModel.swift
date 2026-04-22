//
//  HabitModel.swift
//  Contacts
//

import SwiftUI

struct HabitBoard: Identifiable {
    let id = UUID()
    var name: String
    var icon: String
    var themeColor: Color
    
    // 0 = empty, 1 = light, 2 = medium, 3 = full completion.
    // 140 days = 20 weeks (7 days * 20 columns)
    var activityHistory: [Int]
}

// Mock data to test our UI
let mockHabits: [HabitBoard] = [
    HabitBoard(
        name: "Journal",
        icon: "✏️",
        themeColor: .gray,
        activityHistory: Array(repeating: 0, count: 140)
    ),
    HabitBoard(
        name: "Exercise",
        icon: "🏃‍♂️",
        themeColor: .green,
        // Randomly generating 0 to 3 for the preview
        activityHistory: (0..<140).map { _ in Int.random(in: 0...3) }
    ),
    HabitBoard(
        name: "Read a book",
        icon: "📚",
        themeColor: .green,
        activityHistory: (0..<140).map { _ in Int.random(in: 0...2) }
    )
]
