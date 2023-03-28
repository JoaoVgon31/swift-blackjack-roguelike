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
    
    init(name: String, attributes: Attributes, bounty: Int, effectCards: Array<EffectCard>) {
        super.init(name: name, attributes: attributes, effectCards: effectCards)
        self.bounty = bounty
    }
    
    override func makePlay(battleCards cards: inout Array<String>, oponentCardsTotal: Int) {
        if !stopped {
            var attackGambleOnHand = countEffectCardsOnHandByName("Aposta de Ataque")
            var temporaryArmorOnHand = countEffectCardsOnHandByName("Armadura Temporária")
            let cardsTotalToOponentCardsTotal = oponentCardsTotal - cardsTotal
            let cardsTotalTo21 = 21 - cardsTotal
            printAsTitle("Vez de \(name)")
            printEffectCards(onHand: true)
            print(attackGambleOnHand)
            print(temporaryArmorOnHand)
            print(cardsTotalToOponentCardsTotal)
            print(cardsTotalTo21)
            if (cardsTotal >= 17) {
                if cardsTotalToOponentCardsTotal < 0 {
                    if cardsTotalTo21 <= 3 {
                        while attributes.chips > attackGamble.cost && attackGambleOnHand > 0 {
                            guard let attackGamble = effectCardsHand.first(where: { effectCard in effectCard.text.getText(withEffectDescription: false) == "Aposta de Ataque" }) else {
                                break
                            }
                            attackGamble.use(from: self)
                            attackGambleOnHand -= 1
                        }
                    }
                    else if cardsTotalToOponentCardsTotal <= -4 {
                        while attributes.chips > attackGamble.cost && attackGambleOnHand > 0 {
                            guard let attackGamble = effectCardsHand.first(where: { effectCard in effectCard.text.getText(withEffectDescription: false) == "Aposta de Ataque" }) else {
                                break
                            }
                            attackGamble.use(from: self)
                            attackGambleOnHand -= 1
                            break
                        }
                    }
                } else if cardsTotalToOponentCardsTotal > 0 {
                    if oponentCardsTotal == 21 {
                        while attributes.chips > temporaryArmor.cost && temporaryArmorOnHand > 0 {
                            guard let temporaryArmor = effectCardsHand.first(where: { effectCard in effectCard.text.getText(withEffectDescription: false) == "Armadura Temporária" }) else {
                                break
                            }
                            temporaryArmor.use(from: self)
                            temporaryArmorOnHand -= 1
                        }
                    } else {
                        while attributes.chips > temporaryArmor.cost && temporaryArmorOnHand > 0 {
                            guard let temporaryArmor = effectCardsHand.first(where: { effectCard in effectCard.text.getText(withEffectDescription: false) == "Armadura Temporária" }) else {
                                break
                            }
                            temporaryArmor.use(from: self)
                            temporaryArmorOnHand -= 1
                            break
                        }
                    }
                }
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
