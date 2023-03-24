//
//  Player.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Player: Character {
    private var _money: Int = 0
    var money: Int {
        get { _money }
        set {
            if newValue >= 0 {
                _money = newValue
            }
        }
    }
    
    override init() {
        super.init()
        self.money = 0
    }
    
    init(attributes: Attributes, money: Int, effectCards: Array<EffectCard>) {
        print("\nInforme o nome da pessoa que irá jogar:")
        super.init(name: Player.readName(), attributes: attributes, effectCards: effectCards)
        self.money = money
    }
    
    private static func readName() -> String {
        if let input = readLine() {
            return input
        }
        return "Personagem"
    }

    override func makePlay(battleCards cards: inout Array<String>) {
        var endedTurn = false
        if !stopped {
            printAsTitle("Vez de \(name)")
            while !endedTurn {
                printHandAndCardsTotal()
                printEffectCards(onHand: true)
                printOptions("Pegar uma carta", "Usar carta de efeito. Fichas: \(attributes.chips)k", "Parar")
                let selectedOption = readIntInClosedRange(range: 1...3)
                if selectedOption == 1 {
                    takeCard(from: &cards)
                    printHandAndCardsTotal()
                    endedTurn = true
                } else if selectedOption == 2 {
                    if effectCardsHand.isEmpty {
                        print("\nVocê não possui cartas de efeito na mão")
                    } else {
                        var effectCardsHandNames: Array<String> = []
                        effectCardsHand.forEach{effectCard in effectCardsHandNames.append(effectCard.name)}
                        printOptions(effectCardsHandNames)
                        let selectedEffectCardOption = readIntInClosedRange(range: 1...effectCardsHand.count)
                        let selectedEffectCard = effectCardsHand.remove(at: selectedEffectCardOption - 1)
                        effectCardsDiscardPile.append(selectedEffectCard)
                        selectedEffectCard.use(from: self)
                    }
                    pressEnterToContinue()
                } else if selectedOption == 3 {
                    stopped = true
                    endedTurn = true
                }
            }
        } else {
            printAsTitle("\(name) parou")
            printHandAndCardsTotal()
        }
        pressEnterToContinue()
    }
}
