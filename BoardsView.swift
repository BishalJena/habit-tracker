//
//  BoardsView.swift
//  Contacts
//

import SwiftUI

struct BoardsView: View {
    @State private var habits = mockHabits

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(habits) { habit in
                        HabitCardView(habit: habit)
                            .padding(.horizontal, 24)

                        if habit.id != habits.last?.id {
                            Divider()
                                .padding(.horizontal, 24)
                        }
                    }
                }
                .padding(.top, 8)
                .padding(.bottom, 32)
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
}
