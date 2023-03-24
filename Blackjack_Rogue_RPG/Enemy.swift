//
//  Enemy.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Enemy: Character {
    private var _bounty: Int = 0
    var bounty: Int {
        get { _bounty }
        set {
            if newValue >= 5 {
                _bounty = newValue
            }
        }
    }
    
    override init() {
        super.init()
        self.bounty = 0
    }
    
    init(name: String, attributes: Attributes, bounty: Int) {
        super.init(name: name, attributes: attributes)
        self.bounty = bounty
    }
    
    override func makePlay(battleCards cards: inout Array<String>) {
        if !stopped {
            printAsTitle("Vez de \(name)")
            if (cardsTotal >= 17) {
                print("\n\(name) parou")
                printHandAndCardsTotal()
                stopped = true
            } else {
                print("\n\(name) pegou uma carta")
                takeCard(from: &cards)
                printHandAndCardsTotal()
            }
        } else {
            printAsTitle("\(name) parou")
            printHandAndCardsTotal()
        }
        pressEnterToContinue()
    }
}
