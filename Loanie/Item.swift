//
//  Item.swift
//  Loanie
//
//  Created by Kajetan Pająkowski on 06/11/2026.
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
