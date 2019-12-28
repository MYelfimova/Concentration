//
//  Concentration.swift
//  Concentration
//
//  Created by Air on 30.11.2019.
//  Copyright © 2019 Hummus Inc. All rights reserved.
//

import Foundation

class Concentration {
    
    //initialising a set of cards
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyCardFaceUp: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp{
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyCardFaceUp, matchIndex != index {
                
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }
            else {
                // else no card or 2 cards are faceup
                indexOfOneAndOnlyCardFaceUp = index
            }
   
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): Number of paor of cards has to be for than 1")
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shuffle cards
        cards = cards.shuffled()
    }
    
}
