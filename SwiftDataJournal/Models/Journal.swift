//
//  Journal.swift
//  SwiftDataJournal
//
//  Created by Parker Rushton on 6/4/25.
//
//

import Foundation
import SwiftData

@Model
class Journal {
    var createdAt: Date
    var id: String
    var title: String
    @Relationship(deleteRule: .cascade, inverse: \Entry.journal) var entries = [Entry]()

    init(title: String, colorHex: String?) {
        self.id = UUID().uuidString
        self.createdAt = Date()
        self.title = title
    }

}
