//
//  ContentView.swift
//  Contacts
//

import SwiftUI

struct ContentView: View {

    @State private var contacts = mockContacts
    @State private var searchText = ""
    @State private var selectedContact: Contact? = nil

    // MARK: - Filtered Contacts
    var filteredContacts: [Contact] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter {
                ($0.firstName + " " + $0.lastName)
                    .localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    // MARK: - Grouped
    var groupedContacts: [String: [Contact]] {
        Dictionary(grouping: filteredContacts) { $0.firstLetter }
    }

    var sectionTitles: [String] {
        groupedContacts.keys.sorted()
    }

    var body: some View {
        TabView {
            // TAB 1: Contacts
            NavigationStack {
                ScrollViewReader { proxy in
                    List {
                        ForEach(sectionTitles, id: \.self) { key in
                            Section(key) {
                                ForEach(groupedContacts[key] ?? []) { contact in
                                    ContactRow(contact: contact)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            selectedContact = contact
                                        }
                                }
                            }
                            .listSectionSeparator(.hidden, edges: .bottom)
                            .id(key)
                        }
                    }
                    .listStyle(.plain)
                    .overlay(alignment: .trailing) {
                        IndexBar(letters: sectionTitles) { letter in
                            withAnimation(.easeInOut(duration: 0.2)) {
                                proxy.scrollTo(letter, anchor: .top)
                            }
                        }
                        .padding(.trailing, 2)
                    }
                    .navigationTitle("Contacts")
                    .searchable(
                        text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search"
                    )
                }
            }
            .sheet(item: $selectedContact) { contact in
                CreateHabitView(partner: contact)
            }
            .tabItem {
                Label("Contacts", systemImage: "person.2.fill")
            }

            // TAB 2: Boards
            BoardsView()
                .tabItem {
                    Label("Boards", systemImage: "rectangle.split.3x1")
                }
        }
    }
}

// MARK: - Draggable Index Bar
struct IndexBar: View {
    let letters: [String]
    let onSelect: (String) -> Void

    @State private var draggedLetter: String? = nil

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 1) {
                ForEach(letters, id: \.self) { letter in
                    Text(letter)
                        .font(.caption2.bold())
                        .foregroundStyle(draggedLetter == letter ? .white : .blue)
                        .frame(width: 18, height: 14)
                        .background(
                            draggedLetter == letter
                                ? Circle().fill(Color.blue)
                                : Circle().fill(Color.clear)
                        )
                        .contentShape(Rectangle())
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
            .background(.ultraThinMaterial, in: Capsule())
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { value in
                        let totalHeight = geo.size.height
                        let itemHeight = totalHeight / CGFloat(letters.count)
                        let index = Int((value.location.y / itemHeight))
                            .clamped(to: 0...(letters.count - 1))
                        let letter = letters[index]
                        if draggedLetter != letter {
                            draggedLetter = letter
                            onSelect(letter)
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        }
                    }
                    .onEnded { _ in
                        draggedLetter = nil
                    }
            )
        }
        .frame(width: 26)
    }
}

// MARK: - Contact Row
struct ContactRow: View {
    let contact: Contact

    var initials: String {
        let first = contact.firstName.prefix(1)
        let last = contact.lastName.prefix(1)
        return "\(first)\(last)"
    }

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(.blue.opacity(0.15))
                .frame(width: 42, height: 42)
                .overlay {
                    Text(initials.uppercased())
                        .font(.subheadline.bold())
                        .foregroundStyle(.blue)
                }

            VStack(alignment: .leading, spacing: 2) {
                Text("\(contact.firstName) \(contact.lastName)")
                    .font(.body)

                Text("Mobile")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()

            // Hint chevron
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(HabitStore())
}

// MARK: - Helpers
extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
