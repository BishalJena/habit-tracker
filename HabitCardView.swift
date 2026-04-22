//
//  HabitCardView.swift
//  Contacts
//

import SwiftUI

// MARK: - Habit Card View
struct HabitCardView: View {
    let habit: HabitBoard

    /// Pairs each activityHistory entry with its real calendar date.
    /// History[0] = oldest day, History[last] = today.
    var days: [(date: Date, intensity: Int)] {
        let calendar = Calendar.current
        let today = Date()
        let count = habit.activityHistory.count
        return habit.activityHistory.enumerated().map { index, intensity in
            let daysAgo = count - 1 - index
            let date = calendar.date(byAdding: .day, value: -daysAgo, to: today) ?? today
            return (date: date, intensity: intensity)
        }
    }

    /// Groups days by month so we can show a month header when the month changes.
    var groupedByMonth: [(monthLabel: String, days: [(date: Date, intensity: Int)])] {
        var groups: [(String, [(Date, Int)])] = []
        var currentMonth = ""
        var currentGroup: [(Date, Int)] = []

        for day in days {
            let label = monthString(for: day.date)
            if label != currentMonth {
                if !currentGroup.isEmpty {
                    groups.append((currentMonth, currentGroup))
                }
                currentMonth = label
                currentGroup = [(day.date, day.intensity)]
            } else {
                currentGroup.append((day.date, day.intensity))
            }
        }
        if !currentGroup.isEmpty {
            groups.append((currentMonth, currentGroup))
        }
        return groups.map { ($0.0, $0.1.map { (date: $0.0, intensity: $0.1) }) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Habit name — large, bold, lowercase
            Text(habit.name.lowercased())
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.primary)
                .padding(.bottom, 2)

            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(groupedByMonth, id: \.monthLabel) { group in
                            VStack(alignment: .leading, spacing: 6) {
                                // Month label
                                Text(group.monthLabel)
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.secondary)
                                    .padding(.leading, 4)

                                // Day circles row
                                HStack(spacing: 8) {
                                    ForEach(group.days.indices, id: \.self) { i in
                                        let day = group.days[i]
                                        DayCircle(date: day.date, intensity: day.intensity)
                                            .id(day.date)
                                    }
                                }
                            }
                            .padding(.trailing, 16)
                        }
                    }
                    .padding(.horizontal, 2)
                }
                .onAppear {
                    // Scroll to show today on load
                    if let today = days.last?.date {
                        proxy.scrollTo(today, anchor: .trailing)
                    }
                }
            }
        }
        .padding(.vertical, 16)
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

    /// Single-letter weekday (M / T / W …)
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
        HabitCardView(habit: mockHabits[1])
            .padding(.horizontal)
    }
}
