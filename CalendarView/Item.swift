//
//  Item.swift
//  CalendarView
//
//  Created by Riku on 2024/09/01.
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
