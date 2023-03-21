//
//  GameTable.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class BattleTable {
    static let cards = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Q", "J", "K"]
    var battleCards: Array<String> = []
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
    
    private func generateBattleCards(quantityOfDecks: Int = 2) {
        battleCards = []
        for _ in 1...quantityOfDecks {
            for card in BattleTable.cards {
                for _ in 1...4 {
                    battleCards.append(card);
                }
            }
        }
    }
    
    private func dealInitialHands(from cards: inout Array<String>, for characters: Array<Character>) {
        for character in characters {
            character.clearHand()
            character.takeCard(from: &cards)
            character.takeCard(from: &cards)
        }
    }
    
    private func battleEnded() -> Bool {
        if enemy.attributes.health <= 0 {
            printAsTitle("Fim de Jogo")
            print("\n\(player.name) ganhou o jogo com \(player.attributes.health) pontos de vida restantes")
            print("\(enemy.name) perdeu o jogo")
            return true
        } else if player.attributes.health <= 0 {
            printAsTitle("Fim de Jogo")
            print("\n\(enemy.name) ganhou o jogo com \(enemy.attributes.health) pontos de vida restantes")
            print("\(player.name) perdeu o jogo")
            return true
        }
        return false
    }
    
    private func roundEnded() -> Bool {
        if player.stopped && enemy.stopped || player.cardsTotal > 21 || enemy.cardsTotal > 21 {
            printAsTitle("Fim da Rodada")
            if player.cardsTotal > enemy.cardsTotal && player.cardsTotal <= 21 || enemy.cardsTotal > 21 {
                print("\n\(player.name) ganhou a rodada")
                var damage: Int = player.attributes.damage
                if (enemy.cardsTotal > 21) {
                    damage += enemy.cardsTotal - 21
                } else {
                    damage += player.cardsTotal - enemy.cardsTotal
                }
                print("\(enemy.name) perde \(damage) pontos de vida")
                enemy.attributes.health -= damage
            } else if player.cardsTotal < enemy.cardsTotal && enemy.cardsTotal <= 21 || player.cardsTotal > 21 {
                print("\n\(enemy.name) ganhou a rodada")
                var damage: Int = enemy.attributes.damage
                if (player.cardsTotal > 21) {
                    damage += player.cardsTotal - 21
                } else {
                    damage += enemy.cardsTotal - player.cardsTotal
                }
                print("\(player.name) perde \(damage) pontos de vida")
                player.attributes.health -= damage
            } else {
                print("\nRodada empatou")
            }
            player.printHealth()
            enemy.printHealth()
            
            pressEnterToContinue()
            return true
        }
        return false
    }
    
    private func startNewRound() {
        printAsTitle("Começando nova rodada")
        dealInitialHands(from: &battleCards, for: [player, enemy])
        player.printHandAndCardsTotal()
        player.printHealth()
        enemy.printHandAndCardsTotal()
        enemy.printHealth()
        pressEnterToContinue()
        manageRound()
    }
    
    private func manageRound() {
        while true {
            currentTurn += 1
            if currentTurn % 2 == 1 {
                if manageTurn(for: player) {
                    return
                }
            } else {
                if manageTurn(for: enemy) {
                    return
                }
            }
        }
    }
    
    private func manageTurn(for character: Character) -> Bool {
        character.makePlay(battleCards: &battleCards)
        return roundEnded()
    }
    
    private func manageBattle() {
        while !battleEnded() {
            startNewRound()
        }
    }
    
    func startNewBattle() {
        generateBattleCards()
        player = Player(attributes: Attributes(health: 30, damage: 4))
        enemy = Enemy(name: "Inimigo", attributes: Attributes(health: 30, damage: 4))
        currentTurn = 0
        manageBattle()
    }
}
