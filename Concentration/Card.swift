//
//  Card.swift
//  Concentration
//
//  Created by Air on 30.11.2019.
//  Copyright © 2019 Hummus Inc. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var hasBeenSeen = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
