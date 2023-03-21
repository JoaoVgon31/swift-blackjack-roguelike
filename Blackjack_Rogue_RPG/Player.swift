//
//  Player.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Player: Character {
    override init() {
        super.init()
    }
    
    init(attributes: Attributes) {
        print("\nInforme o nome da pessoa que irá jogar:")
        super.init(name: Player.readName(), attributes: attributes)
    }
    
    static func readName() -> String {
        if let input = readLine() {
            return input
        }
        return "Personagem"
    }

    override func makePlay(battleCards cards: inout Array<String>) {
        if !stopped {
            printAsTitle("Vez de \(name)")
            printHandAndCardsTotal()
            print("\nSelecione uma das opções:\n1.Pegar uma carta \n2.Parar")
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
