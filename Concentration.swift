//
//  Concentration.swift
//  Concentration
//
//  Created by Air on 30.11.2019.
//  Copyright © 2019 Hummus Inc. All rights reserved.
//

import Foundation

class Concentration {
    
    //initialising
    var cards = [Card]()
    
    var indexOfOneAndOnlyCardFaceUp: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyCardFaceUp, matchIndex != index {
                
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyCardFaceUp = nil
            }
            else {
                // else no card or 2 cards are faceup
                for flipDownIndices in cards.indices {
                    cards[flipDownIndices].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyCardFaceUp = index
            }
   
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shuffle cards
        
    }
    
}
