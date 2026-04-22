//
//  HabitStore.swift
//  Contacts
//

import SwiftUI

class HabitStore: ObservableObject {
    @Published var habits: [HabitBoard] = []

    // MARK: - Check in for today
    func checkIn(habitId: UUID) {
        guard let i = habits.firstIndex(where: { $0.id == habitId }) else { return }
        habits[i].myHistory[habits[i].myHistory.count - 1] = 1
    }

    // MARK: - Add new habit (created from contact flow)
    func addHabit(name: String, icon: String = "⭐️", partner: Contact?, reminderTime: Date?) {
        let habit = HabitBoard(
            name: name,
            icon: icon,
            reminderTime: reminderTime,
            myHistory: Array(repeating: 0, count: 140),
            partner: partner
            // partnerHistory auto-generated randomly in init
        )
        habits.append(habit)
    }
}
