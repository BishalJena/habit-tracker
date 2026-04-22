//
//  HabitModel.swift
//  Contacts
//

import SwiftUI

struct HabitBoard: Identifiable {
    let id: UUID
    var name: String
    var icon: String
    var reminderTime: Date?

    // Binary history: 0 = not done, 1 = done.
    // Index 0 = oldest day, last index = today (140 days total).
    var myHistory: [Int]

    // Accountability partner + their simulated history.
    var partner: Contact?
    var partnerHistory: [Int]

    init(
        id: UUID = UUID(),
        name: String,
        icon: String = "⭐️",
        reminderTime: Date? = nil,
        myHistory: [Int] = Array(repeating: 0, count: 140),
        partner: Contact? = nil,
        partnerHistory: [Int] = []
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.reminderTime = reminderTime
        self.myHistory = myHistory
        self.partner = partner
        self.partnerHistory = partnerHistory.isEmpty
            ? (0..<140).map { _ in Int.random(in: 0...1) }
            : partnerHistory
    }

    var todayCheckedIn: Bool { myHistory.last == 1 }
}

// Kept only as a fallback so previews compile when the store is empty.
let mockHabits: [HabitBoard] = []
