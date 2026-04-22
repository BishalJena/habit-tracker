//
//  CreateHabitView.swift
//  Contacts
//

import SwiftUI

struct CreateHabitView: View {
    let partner: Contact

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: HabitStore

    @State private var habitName = ""
    @State private var reminderEnabled = false
    @State private var reminderTime = Calendar.current.date(
        bySettingHour: 9, minute: 0, second: 0, of: Date()
    ) ?? Date()

    private var partnerInitials: String {
        "\(partner.firstName.prefix(1))\(partner.lastName.prefix(1))"
    }

    var body: some View {
        NavigationStack {
            Form {
                // ── Habit name ──
                Section {
                    TextField("e.g. Read for 30 minutes", text: $habitName)
                        .font(.body)
                } header: {
                    Text("Habit")
                }

                // ── Reminder ──
                Section {
                    Toggle("Daily Reminder", isOn: $reminderEnabled.animation())
                    if reminderEnabled {
                        DatePicker(
                            "Time",
                            selection: $reminderTime,
                            displayedComponents: .hourAndMinute
                        )
                    }
                } header: {
                    Text("Reminder")
                }

                // ── Partner ──
                Section {
                    HStack(spacing: 12) {
                        Circle()
                            .fill(.blue.opacity(0.15))
                            .frame(width: 40, height: 40)
                            .overlay {
                                Text(partnerInitials.uppercased())
                                    .font(.subheadline.bold())
                                    .foregroundStyle(.blue)
                            }

                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(partner.firstName) \(partner.lastName)")
                                .font(.body)
                            Text("Your accountability partner")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                } header: {
                    Text("Partner")
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(.secondary)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Create") {
                        store.addHabit(
                            name: habitName.trimmingCharacters(in: .whitespaces),
                            partner: partner,
                            reminderTime: reminderEnabled ? reminderTime : nil
                        )
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .disabled(habitName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    CreateHabitView(partner: darma)
        .environmentObject(HabitStore())
}
