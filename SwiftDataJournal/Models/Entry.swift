//
//  Entry.swift
//  SwiftDataJournal
//
//  Created by Parker Rushton on 6/4/25.
//
//

import Foundation
import SwiftData

@Model class Entry {
    var body: String
    var createdAt: Date
    var updatedAt: Date
    var id: String
    // BD
//    @Attribute(.externalStorage) var imageData: Data?
    var title: String
    var journal: Journal?

    init(journal: Journal, title: String, body: String, imageData: Data? = nil) {
        self.id = UUID().uuidString
        self.createdAt = Date()
        self.updatedAt = Date()
        self.title = title
        self.body = body
        // BD
//        self.imageData = imageData
        self.journal = journal
    }

}
