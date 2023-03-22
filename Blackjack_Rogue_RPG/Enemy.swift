//
//  Enemy.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Enemy: Character {
    var bounty: Int
    
    override init() {
        self.bounty = 0
        super.init()
    }
    
    init(name: String, attributes: Attributes, bounty: Int) {
        self.bounty = bounty
        super.init(name: name, attributes: attributes)
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
