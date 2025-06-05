//
//  JournalsView.swift
//  SwiftDataJournal
//
//  Created by Parker Rushton on 6/4/25.
//

import SwiftUI
import SwiftData

struct JournalsView: View {

    @Query(sort: \Journal.createdAt, order: .reverse) var journals: [Journal]
    @Environment(\.modelContext) private var modelContext

    @State private var isShowingAddAlert = false
    @State private var newJournalTitle = ""

    var body: some View {
        NavigationStack {
            ZStack {
                if journals.isEmpty {
                    emptyStateView()
                } else {
                    List(journals) { journal in
                        NavigationLink(destination: EntriesView(journal: journal)) {
                            journalView(journal)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Journals")
            .toolbar {
                ToolbarItem {
                    Button(action: { isShowingAddAlert = true }) {
                        Label("Add Journal", systemImage: "plus")
                    }
                }
            }
            .alert("Add New Journal", isPresented: $isShowingAddAlert) {
                alertContent()
            }
        }
    }

    private func emptyStateView() -> some View {
        VStack(spacing: 16) {
            Text("No Journals Yet!")
                .font(.title)
                .foregroundColor(.secondary)

            Button(action: { isShowingAddAlert = true }) {
                Label("Add Your First Journal", systemImage: "plus.circle.fill")
                    .font(.headline)
            }
        }
    }

    private func alertContent() -> some View {
        Group {
            TextField("Journal Title", text: $newJournalTitle)
            Button("Cancel", role: .cancel) {
                newJournalTitle = ""
            }
            Button("Add") {
                addJournal()
            }
        }
    }

    func journalView(_ journal: Journal) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(journal.title)
                    .bold()

                Text("Entries: \(journal.entries.count)")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
        }
    }

}

// MARK: - Private extension

private extension JournalsView {

    func addJournal() {
        guard !newJournalTitle.isEmpty else { return }
        withAnimation {
            let newJournal = Journal(title: newJournalTitle, colorHex: nil)
            modelContext.insert(newJournal)
            newJournalTitle = ""
        }
    }

}

#Preview {
    JournalsView()
}
