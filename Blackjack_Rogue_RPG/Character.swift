//
//  Character.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Character {
    var name: String
    var hand: Array<String> = []
    var cardsTotal: Int = 0
    var stopped: Bool = false
    var attributes: Attributes
    
    init() {
        self.name = "Personagem"
        self.attributes = Attributes(health: 30, attackDamage: 4, criticalMultiplier: 1.1)
    }
    
    init(name: String, attributes: Attributes) {
        self.name = name
        self.attributes = attributes
    }
    
    func printHandAndCardsTotal() {
        print("\nMão de \(name): \(hand)")
        print("Valor total cartas \(name): \(cardsTotal)")
    }
    
    func printAttributes() {
        print("\(name) possui \(attributes.health) pontos de vida")
        print("\(name) possui \(attributes.attackDamage) pontos de ataque")
        print("\(name) possui \(attributes.criticalMultiplier) multiplicador de dano crítico")
    }
    
    func takeCard(from cards: inout Array<String>) {
        let position = Int.random(in: 0..<cards.count)
        hand.append(cards[position])
        cardsTotal += BattleTable.getCardValue(card: cards[position])
        cards.remove(at: position)
    }
    
    func clearHand() {
        hand.removeAll()
        cardsTotal = 0
        stopped = false
    }
    
    func makePlay(battleCards cards: inout Array<String>){}
}
