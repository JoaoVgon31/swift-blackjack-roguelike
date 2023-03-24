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
    
    init(attributes: Attributes, money: Int) {
        print("\nInforme o nome da pessoa que irá jogar:")
        super.init(name: Player.readName(), attributes: attributes)
        self.money = money
    }
    
    private static func readName() -> String {
        if let input = readLine() {
            return input
        }
        return "Personagem"
    }

    override func makePlay(battleCards cards: inout Array<String>) {
        if !stopped {
            printAsTitle("Vez de \(name)")
            printHandAndCardsTotal()
            printOptions("Pegar uma carta", "Parar")
            let selectedOption = readIntInClosedRange(range: 1...2)
            if selectedOption == 1 {
                takeCard(from: &cards)
                printHandAndCardsTotal()
            } else if selectedOption == 2 {
                stopped = true
            }
        } else {
            printAsTitle("\(name) parou")
            printHandAndCardsTotal()
        }
        pressEnterToContinue()
    }
}
