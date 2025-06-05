//
//  SwiftDataJournalApp.swift
//  SwiftDataJournal
//
//  Created by Parker Rushton on 6/4/25.
//

import Foundation

var relativeDateFormatter: RelativeDateTimeFormatter = {
    let formatter = RelativeDateTimeFormatter()
    formatter.dateTimeStyle = .named
    return formatter
}() 
