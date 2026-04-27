//
//  HabitCardView.swift
//  Contacts
//

import SwiftUI

// MARK: - Main Card
struct HabitCardView: View {
    let habit: HabitBoard
    @EnvironmentObject private var store: HabitStore

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // ── Habit name ──
            Text(habit.name.lowercased())
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.primary)
                .padding(.bottom, 14)

            // ── My row ──
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .center) {
                    Text("you")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.secondary)

                    Spacer()

                    // Check-in button
                    Button {
                        store.checkIn(habitId: habit.id)
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: habit.todayCheckedIn ? "checkmark.circle.fill" : "circle")
                                .font(.system(size: 13))
                            Text(habit.todayCheckedIn ? "Done" : "Check in")
                                .font(.system(size: 12, weight: .semibold))
                        }
                        .foregroundColor(habit.todayCheckedIn ? .green : .white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            habit.todayCheckedIn
                                ? Color.green.opacity(0.12)
                                : Color.black
                        )
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(habit.todayCheckedIn ? Color.green.opacity(0.3) : Color.clear, lineWidth: 1)
                        )
                    }
                    .animation(.easeInOut(duration: 0.2), value: habit.todayCheckedIn)
                }

                HabitCirclesRow(history: habit.myHistory)
            }

            // ── Partner row (only when a partner is linked) ──
            if let partner = habit.partner {
                Divider()
                    .padding(.vertical, 12)

                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 6) {
                        Circle()
                            .fill(.blue.opacity(0.12))
                            .frame(width: 18, height: 18)
                            .overlay {
                                Text(partner.firstName.prefix(1).uppercased())
                                    .font(.system(size: 9, weight: .bold))
                                    .foregroundStyle(.blue)
                            }

                        Text(partner.firstName.lowercased())
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.secondary)
                    }

                    HabitCirclesRow(history: habit.partnerHistory)
                }
            }
        }
        .padding(.vertical, 20)
    }
}

// MARK: - Shared Day Circle Row
struct HabitCirclesRow: View {
    let history: [Int]

    private var days: [(date: Date, intensity: Int)] {
        let calendar = Calendar.current
        let today = Date()
        return history.enumerated().map { index, intensity in
            let daysAgo = history.count - 1 - index
            let date = calendar.date(byAdding: .day, value: -daysAgo, to: today) ?? today
            return (date: date, intensity: intensity)
        }
    }

    /// Groups consecutive days by month label.
    private var groupedByMonth: [(label: String, days: [(date: Date, intensity: Int)])] {
        var result: [(String, [(Date, Int)])] = []
        var currentLabel = ""
        var currentGroup: [(Date, Int)] = []

        for day in days {
            let label = monthString(for: day.date)
            if label != currentLabel {
                if !currentGroup.isEmpty { result.append((currentLabel, currentGroup)) }
                currentLabel = label
                currentGroup = [(day.date, day.intensity)]
            } else {
                currentGroup.append((day.date, day.intensity))
            }
        }
        if !currentGroup.isEmpty { result.append((currentLabel, currentGroup)) }
        return result.map { ($0.0, $0.1.map { (date: $0.0, intensity: $0.1) }) }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(groupedByMonth, id: \.label) { group in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(group.label)
                            .font(.system(size: 11, weight: .regular))
                            .foregroundColor(.secondary)
                            .padding(.leading, 2)

                        HStack(spacing: 8) {
                            ForEach(group.days.indices, id: \.self) { i in
                                let day = group.days[i]
                                DayCircle(date: day.date, intensity: day.intensity)
                            }
                        }
                    }
                    .padding(.trailing, 16)
                }
            }
            .padding(.horizontal, 2)
        }
        .defaultScrollAnchor(.trailing)
    }

    private func monthString(for date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "MMM"
        return f.string(from: date).lowercased()
    }
}

// MARK: - Day Circle
struct DayCircle: View {
    let date: Date
    let intensity: Int

    private var dayNumber: String {
        "\(Calendar.current.component(.day, from: date))"
    }

    private var dayLetter: String {
        let f = DateFormatter()
        f.dateFormat = "EEEEE"
        return f.string(from: date)
    }

    private var isCompleted: Bool { intensity > 0 }

    private var isFuture: Bool {
        Calendar.current.compare(date, to: Date(), toGranularity: .day) == .orderedDescending
    }

    var body: some View {
        VStack(spacing: 4) {
            Circle()
                .fill(circleColor)
                .frame(width: 44, height: 44)
                .overlay {
                    Text(dayNumber)
                        .font(.system(size: 15, weight: isCompleted ? .semibold : .regular))
                        .foregroundColor(numberColor)
                }

            Text(dayLetter)
                .font(.system(size: 11))
                .foregroundColor(.secondary)
        }
    }

    private var circleColor: Color {
        if isCompleted { return Color.primary }
        if isFuture    { return Color.gray.opacity(0.08) }
        return Color.gray.opacity(0.15)
    }

    private var numberColor: Color {
        if isCompleted { return Color(UIColor.systemBackground) }
        if isFuture    { return Color.secondary.opacity(0.4) }
        return Color.secondary
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color(UIColor.systemBackground).ignoresSafeArea()
        HabitCardView(habit: HabitBoard(
            name: "Exercise",
            icon: "🏃",
            myHistory: (0..<140).map { _ in Int.random(in: 0...1) },
            partner: morad,
            partnerHistory: (0..<140).map { _ in Int.random(in: 0...1) }
        ))
        .environmentObject(HabitStore())
        .padding(.horizontal, 0)
    }
}
