//
//  HabitStore.swift
//  Contacts
//

import SwiftUI
import Combine

class HabitStore: ObservableObject {
    @Published var habits: [HabitBoard]

    init() {
        // Seed with demo habits so Boards isn't empty on first launch.
        habits = [
            HabitBoard(
                name: "Exercise",
                icon: "🏃",
                myHistory: HabitStore.realisticHistory(completionRate: 0.7),
                partner: morad,
                partnerHistory: HabitStore.realisticHistory(completionRate: 0.55)
            ),
            HabitBoard(
                name: "Read a book",
                icon: "📚",
                myHistory: HabitStore.realisticHistory(completionRate: 0.6),
                partner: morad,
                partnerHistory: HabitStore.realisticHistory(completionRate: 0.8)
            ),
            HabitBoard(
                name: "Journal",
                icon: "✏️",
                myHistory: HabitStore.realisticHistory(completionRate: 0.5),
                partner: morad,
                partnerHistory: HabitStore.realisticHistory(completionRate: 0.45)
            )
        ]
    }

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
        )
        habits.append(habit)
    }

    // MARK: - Helpers
    /// Generates 140 days of history with a given overall completion rate,
    /// with today (last entry) always 0 so the check-in button is active.
    static func realisticHistory(completionRate: Double) -> [Int] {
        var history = (0..<139).map { _ in
            Double.random(in: 0...1) < completionRate ? 1 : 0
        }
        history.append(0) // today — not yet checked in
        return history
    }
}
