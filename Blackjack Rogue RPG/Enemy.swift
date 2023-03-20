//
//  Enemy.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Enemy: Character {
    override func makePlay(gameCards cards: inout Array<String>) {
        if !stopped {
            print("\n__________Vez de \(name)__________")
            if (cardsTotal >= 17) {
                print("\n\(name) parou")
                stopped = true
            } else {
                print("\n\(name) pegou uma carta")
                takeCard(from: &cards)
                printHandAndCardsTotal()
            }
        }
    }
}
