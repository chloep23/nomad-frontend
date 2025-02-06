//
//  Item.swift
//  nomad-frontend
//
//  Created by Chloe Park on 2/5/25.
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
