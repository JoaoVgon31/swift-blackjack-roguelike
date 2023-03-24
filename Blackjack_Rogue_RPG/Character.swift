//
//  Character.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Character {
    private var _name: String = ""
    private var _hand: Array<String> = []
    private var _cardsTotal: Int = 0
    private var _stopped: Bool = false
    private var _attributes: Attributes = Attributes()
    var name: String {
        get { _name }
        set {
            if !newValue.isEmpty {
                _name = newValue
            }
        }
    }
    var hand: Array<String> {
        get { _hand }
        set { _hand = newValue }
    }
    var cardsTotal: Int {
        get { _cardsTotal }
        set { _cardsTotal = newValue }
    }
    var stopped: Bool {
        get { _stopped }
        set { _stopped = newValue }
    }
    var attributes: Attributes {
        get { _attributes }
        set { _attributes = newValue }
    }
    
    init() {
        self.name = "Personagem"
        self.attributes = Attributes()
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
