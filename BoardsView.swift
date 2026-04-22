//
//  BoardsView.swift
//  Contacts
//

import SwiftUI

struct BoardsView: View {
    @EnvironmentObject private var store: HabitStore

    var body: some View {
        NavigationStack {
            Group {
                if store.habits.isEmpty {
                    // ── Empty state ──
                    VStack(spacing: 12) {
                        Image(systemName: "person.2")
                            .font(.system(size: 44))
                            .foregroundStyle(.secondary)
                        Text("No habits yet")
                            .font(.headline)
                        Text("Tap a contact to start a shared habit.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(store.habits) { habit in
                                HabitCardView(habit: habit)
                                    .padding(.horizontal, 24)

                                if habit.id != store.habits.last?.id {
                                    Divider()
                                        .padding(.horizontal, 24)
                                }
                            }
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 32)
                    }
                }
            }
            .background(Color(UIColor.systemBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { print("Add tapped") }) {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    BoardsView()
        .environmentObject(HabitStore())
}
