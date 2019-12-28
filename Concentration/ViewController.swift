//
//  ViewController.swift
//  Concentration
//
//  Created by Air on 22.11.2019.
//  Copyright © 2019 Hummus Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count+1)/2
        }
    }
    
    // didSet is an observer - it watches changes in the variable
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
            pointsCountLabel.text = "Points: \(flipCount)"
        }
    }

    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var pointsCountLabel: UILabel!
    
    @IBAction func newGame(_ sender: UIButton) {
        print("New Game button is clicked")
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        flipCount = 0
        updateViewFromModel()
    }
    
    //BASICALLY allows me to generate as many cards as I want and to display on top of then whatever content I want
    @IBOutlet private var cardButtons: [UIButton]!
    
    //BASICALLY this func allows me to react on the clicks on the cards
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        //we find the index of the Button that was just clicked
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        } else{
            print("this card is not in the cardButtons array!!")
        }
    }
    
    // here I collate button(ui-element) and card(concentration element)
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
            
        }
    }
    
    private var emojiChoices = ["👻","🦇","🍎","🍬","🍪","😈","💀","🎃", "🧙🏻‍♀️","💨"]
    
    private var emoji = Dictionary<Int, String>()
    
    private func emoji(for card: Card) -> String {
        var emojiChoicesTemp = emojiChoices // temporary solution!
        if emoji[card.identifier] == nil, emojiChoicesTemp.count > 0 {
            emoji[card.identifier] = emojiChoicesTemp.remove(at: emojiChoicesTemp.count.arc4random)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

// BASICALLY I extend the functionality of Int class. Now I can call the computed variable "arc4random" from any instance variable of class Int: ex 5.arc4random
extension Int {
    var arc4random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}
