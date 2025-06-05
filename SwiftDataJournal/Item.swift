//
//  Item.swift
//  SwiftDataJournal
//
//  Created by Parker Rushton on 5/30/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
