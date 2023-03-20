//
//  main.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

enum InputError: Error {
    case invalid
    case NAN
}

func readIntInput() throws -> Int {
    if let input = readLine() {
        if let intInput = Int(input) {
            return intInput
        } else {
            throw InputError.NAN
        }
    } else {
        throw InputError.invalid
    }
}

func readValidOption(options: ClosedRange<Int>) -> Int {
    while true {
        if let input = try? readIntInput() {
            if options.contains(input) {
                return input
            }
        }
    }
}

class GameTable {
    static let cards = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Q", "J", "K"]
    var gameCards: Array<String> = []
    var player1: Player = Player()
    var player2: Player = Player()
    var currentTurn: Int = 0
    
    static func getCardValue(card: String) -> Int {
        let position = cards.firstIndex(of: card) ?? -1
        if position >= 9 {
            return 10
        } else {
            return position + 1
        }
    }
    
    private func generateGameCards(quantityOfDecks: Int = 1) {
        gameCards = []
        for _ in 1...quantityOfDecks {
            for card in GameTable.cards {
                for _ in 1...4 {
                    gameCards.append(card);
                }
            }
        }
    }
    
    private func dealInitialHands(from cards: inout Array<String>, for players: Array<Player>) {
        for player in players {
            player.takeCard(from: &cards)
            player.takeCard(from: &cards)
        }
    }
    
    private func gameEnded() -> Bool {
        if player1.stopped && player2.stopped || player1.cardsTotal > 21 || player2.cardsTotal > 21 {
            if player1.cardsTotal > player2.cardsTotal && player1.cardsTotal <= 21 || player2.cardsTotal > 21 {
                print("\n\(player1.name) ganhou o jogo com \(player1.cardsTotal)")
                print("\(player2.name) perdeu o jogo com \(player2.cardsTotal)")
            } else if player1.cardsTotal < player2.cardsTotal && player2.cardsTotal <= 21 || player1.cardsTotal > 21 {
                print("\n\(player2.name) ganhou o jogo com \(player2.cardsTotal)")
                print("\(player1.name) perdeu o jogo com \(player1.cardsTotal)")
            } else {
                print("\nJogo empatou")
            }
            return true
        }
        return false
    }
    
    private func manageTurn(for player: Player) -> Bool {
        player.makePlay(gameCards: &gameCards)
        return gameEnded()
    }
    
    func startNewGame() {
        generateGameCards()
        player1 = Player()
        player2 = Player()
        currentTurn = 0
        
        print("\nInforme o nome das duas pessoas que irão jogar:")
        player1.readName()
        player2.readName()
        
        dealInitialHands(from: &gameCards, for: [player1, player2])
        player1.printHandAndCardsTotal()
        player2.printHandAndCardsTotal()
    }
    
    func manageGame() {
        while true {
            if currentTurn % 2 == 0 {
                if manageTurn(for: player1) {
                    return
                }
            } else {
                if manageTurn(for: player2) {
                    return
                }
            }
            currentTurn += 1;
        }
    }
}

class Player {
    var name: String = "Participante"
    var hand: Array<String> = []
    var cardsTotal: Int = 0
    var stopped: Bool = false
    
    func readName() {
        if let input = readLine() {
            name = input
        }
    }
    
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
    
    func makePlay(gameCards cards: inout Array<String>) {
        if !stopped {
            print("\n__________Vez de \(name)__________")
            printHandAndCardsTotal()
            print("\nSelecione uma das opções:\n1.Pegar uma carta \n2.Parar")
            let selectedOption = readValidOption(options: 1...2)
            
            if selectedOption == 1 {
                takeCard(from: &cards)
                printHandAndCardsTotal()
            } else if selectedOption == 2 {
                stopped = true
            }
        }
    }
}

var gameTable = GameTable()
gameTable.startNewGame()

while true {
    gameTable.manageGame()
    
    print("\n__________FIM DE JOGO__________")
    print("\nSelecione uma das opções:\n1.Iniciar novo jogo \n2.Encerrar programa")
    let selectedOption = readValidOption(options: 1...2)
    if selectedOption == 1 {
        gameTable.startNewGame()
        continue
    } else if selectedOption == 2 {
        break
    }
}

