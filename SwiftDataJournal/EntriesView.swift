//
//  ContentView.swift
//  CoreDataJournal
//
//  Created by Parker Rushton on 5/8/24.
//

import SwiftUI
import SwiftData

struct EntriesView: View {
    @Environment(\.modelContext) private var context

    @State private var searchText = ""
    
    var journal: Journal
    
    @State private var isShowingNewEntryView = false
    @State private var selectedEntry: Entry?

    var filteredEntries: [Entry] {
        let journalEntries = journal.entries.sorted {
            $0.updatedAt > $1.updatedAt
        }

        if searchText.isEmpty {
            return journalEntries
        } else {
            return journalEntries.filter { entry in
                entry.title.localizedCaseInsensitiveContains(searchText) ||
                entry.body.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        VStack {
            List {
                ForEach(filteredEntries) { entry in
                    entryView(entry)
                        .onTapGesture {
                            self.selectedEntry = entry
                        }
                }
                .onDelete(perform: { indexSet in
                    delete(at: indexSet)
                })
            }
        }
        .navigationTitle(journal.title)
        .searchable(text: $searchText, prompt: "Search entries...")
        .toolbar {
            ToolbarItem {
                Button(action: showNewEntryView) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $isShowingNewEntryView) {
            AddEditEntryView(journal: journal)
        }
        .sheet(item: $selectedEntry) { entry in
            AddEditEntryView(journal: journal, entry: entry)
        }
    }

    func entryView(_ entry: Entry) -> some View  {
        HStack {
            // BD
//            if let imageData = entry.imageData, let uiImage = UIImage(data: imageData) {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(maxHeight: 50)
//            }

            VStack(alignment: .leading) {
                Text(entry.title)
                    .bold()

                if let relativeString = relativeDateFormatter.string(for: entry.createdAt) {
                    Text(relativeString)
                        .font(.system(.subheadline))
                        .foregroundStyle(Color(.secondaryLabel))
                }
            }

            Spacer()
        }
        .contentShape(Rectangle())
    }

}

extension EntriesView {

    func showNewEntryView() {
        isShowingNewEntryView = true
    }

    func delete(at index: IndexSet) {
        index.forEach { i in
            let entry = filteredEntries[i]
            context.delete(entry)
        }
        try? context.save()
    }

}
