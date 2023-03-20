//
//  main.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

var gameTable = GameTable()
gameTable.startNewGame()

while true {
    gameTable.manageGame()

    print("\n__________FIM DE JOGO__________")
    print("\nSelecione uma das opções:\n1.Iniciar novo jogo \n2.Encerrar programa")
    let selectedOption = readIntInClosedRange(range: 1...2)
    if selectedOption == 1 {
        gameTable.startNewGame()
        continue
    } else if selectedOption == 2 {
        break
    }
}
