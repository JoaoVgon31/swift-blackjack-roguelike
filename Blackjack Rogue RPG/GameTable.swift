//
//  GameTable.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class GameTable {
    static let cards = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Q", "J", "K"]
    var gameCards: Array<String> = []
    var player: Player = Player()
    var enemy: Enemy = Enemy()
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
    
    private func dealInitialHands(from cards: inout Array<String>, for characters: Array<Character>) {
        for character in characters {
            character.takeCard(from: &cards)
            character.takeCard(from: &cards)
        }
    }
    
    private func gameEnded() -> Bool {
        if player.stopped && enemy.stopped || player.cardsTotal > 21 || enemy.cardsTotal > 21 {
            if player.cardsTotal > enemy.cardsTotal && player.cardsTotal <= 21 || enemy.cardsTotal > 21 {
                print("\n\(player.name) ganhou o jogo com \(player.cardsTotal)")
                print("\(enemy.name) perdeu o jogo com \(enemy.cardsTotal)")
            } else if player.cardsTotal < enemy.cardsTotal && enemy.cardsTotal <= 21 || player.cardsTotal > 21 {
                print("\n\(enemy.name) ganhou o jogo com \(enemy.cardsTotal)")
                print("\(player.name) perdeu o jogo com \(player.cardsTotal)")
            } else {
                print("\nJogo empatou")
            }
            return true
        }
        return false
    }
    
    private func manageTurn(for character: Character) -> Bool {
        character.makePlay(gameCards: &gameCards)
        return gameEnded()
    }
    
    func startNewGame() {
        generateGameCards()
        player = Player()
        enemy = Enemy()
        currentTurn = 0
        
        print("\nInforme o nome da pessoa que irá jogar:")
        player.readName()
        
        dealInitialHands(from: &gameCards, for: [player, enemy])
        player.printHandAndCardsTotal()
        enemy.printHandAndCardsTotal()
    }
    
    func manageGame() {
        while true {
            if currentTurn % 2 == 0 {
                if manageTurn(for: player) {
                    return
                }
            } else {
                if manageTurn(for: enemy) {
                    return
                }
            }
            currentTurn += 1;
        }
    }
}
