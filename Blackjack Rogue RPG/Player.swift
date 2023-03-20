//
//  Player.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Player: Character {
    func readName() {
        if let input = readLine() {
            name = input
        }
    }

    override func makePlay(gameCards cards: inout Array<String>) {
        if !stopped {
            print("\n__________Vez de \(name)__________")
            printHandAndCardsTotal()
            print("\nSelecione uma das opções:\n1.Pegar uma carta \n2.Parar")
            let selectedOption = readIntInClosedRange(range: 1...2)
            
            if selectedOption == 1 {
                takeCard(from: &cards)
                printHandAndCardsTotal()
            } else if selectedOption == 2 {
                stopped = true
            }
        }
    }
}
