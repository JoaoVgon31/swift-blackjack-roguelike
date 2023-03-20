//
//  Character.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Character {
    var name: String = "Personagem"
    var hand: Array<String> = []
    var cardsTotal: Int = 0
    var stopped: Bool = false
    
    func printHandAndCardsTotal() {
        print("\nMão de \(name): \(hand)")
        print("Valor total cartas \(name): \(cardsTotal)")
    }
    
    func takeCard(from cards: inout Array<String>) {
        let position = Int.random(in: 0..<cards.count)
        hand.append(cards[position])
        cardsTotal += GameTable.getCardValue(card: cards[position])
        cards.remove(at: position)
    }
    
    func makePlay(gameCards cards: inout Array<String>){}
}
