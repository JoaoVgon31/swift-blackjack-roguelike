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
    private var _effectCards: Array<EffectCard> = []
    private var _effectCardsHand: Array<EffectCard> = []
    private var _effectCardsDiscardPile: Array<EffectCard> = []
    private var _gambleQueue: Queue<GamblingEffectCard> = Queue()
    private var _attributes: Attributes = Attributes()
    private var _battleAttributes: Attributes = Attributes()
    private var _temporaryAttributes: Attributes = Attributes()
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
    var effectCards: Array<EffectCard> {
        get { _effectCards }
        set { _effectCards = newValue }
    }
    var effectCardsHand: Array<EffectCard> {
        get { _effectCardsHand }
        set { _effectCardsHand = newValue }
    }
    var effectCardsDiscardPile: Array<EffectCard> {
        get { _effectCardsDiscardPile }
        set { _effectCardsDiscardPile = newValue }
    }
    var gambleQueue: Queue<GamblingEffectCard> {
        get { _gambleQueue }
        set { _gambleQueue = newValue }
    }
    var attributes: Attributes {
        get { _attributes }
        set { _attributes = newValue }
    }
    var battleAttributes: Attributes {
        get { _battleAttributes }
        set { _battleAttributes = newValue }
    }
    var temporaryAttributes: Attributes {
        get { _temporaryAttributes }
        set { _temporaryAttributes = newValue }
    }
    
    init() {
        self.name = "Personagem"
        self.attributes = Attributes()
    }
    
    init(name: String, attributes: Attributes, effectCards: Array<EffectCard>) {
        self.name = name
        self.attributes = attributes
        self.effectCards = effectCards
    }
    
    func printHandAndCardsTotal() {
        print("\nMão de \(name): \(hand)")
        print("Valor total cartas \(name): \(cardsTotal)")
    }
    
    func printEffectCards(onHand: Bool = false) {
        if onHand {
            print("\nCartas de efeito na mão:")
            effectCardsHand.forEach{effectCard in print("\(effectCard.text.getText()). Custo: \(effectCard.cost)k")}
        } else {
            print("\nCartas de efeito: \(effectCards.forEach{effectCard in print(effectCard.text.getText())})")
        }
    }
    
    func printAttributes() {
        let health = String(format: "%03d", attributes.health)
        let maxHealth = String(format: "%03d", attributes.maxHealth)
        let chips = String(format: "%03d", attributes.chips)
        let maxChips = String(format: "%03d", attributes.maxChips)
        let attackDamage = String(format: "%02d", attributes.attackDamage)
        let criticalMultiplier = String(format: "%04.1f", attributes.criticalMultiplier)
        print("\n\(name)")
        print("________________________________________________________________________________")
        print("| Vida Atual | Vida Máxima | Fichas Atuais | Fichas Máximas | Ataque | Critico |")
        print("|____________|_____________|_______________|________________|________|_________|")
        print("|     \(health)    |     \(maxHealth)     |      \(chips)      |      \(maxChips)       |   \(attackDamage)   |   \(criticalMultiplier)  |")
        print("|____________|_____________|_______________|________________|________|_________|")
    }
    
    func countEffectCardsOnHandByName(_ name: String) -> Int {
        return effectCardsHand.filter{effectCard in effectCard.text.getText(withEffectDescription: false) == name}.count
    }
    
    func takeCard(from cards: inout Array<String>) {
        let position = Int.random(in: 0..<cards.count)
        hand.append(cards[position])
        cardsTotal += BattleTable.getCardValue(card: cards[position])
        if cardsTotal == 21 {
            stopped = true
        }
        cards.remove(at: position)
    }
    
    func clearHand() {
        hand.removeAll()
        cardsTotal = 0
        stopped = false
    }
    
    func makePlay(battleCards cards: inout Array<String>, oponentCardsTotal: Int){}
}
