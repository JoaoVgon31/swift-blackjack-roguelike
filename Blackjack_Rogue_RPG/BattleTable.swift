//
//  GameTable.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class BattleTable {
    public static let cards = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Q", "J", "K"]
    private var _battleCards: Array<String> = []
    private var _player: Player = Player()
    private var _enemy: Enemy = Enemy()
    private var _currentTurn: Int = 0
    var battleCards: Array<String> {
        get { _battleCards }
        set { _battleCards = newValue }
    }
    var player: Player {
        get { _player }
        set { _player = newValue }
    }
    var enemy: Enemy {
        get { _enemy }
        set { _enemy = newValue }
    }
    var currentTurn: Int {
        get { _currentTurn }
        set {
            if newValue >= 0 {
                _currentTurn = newValue
            }
        }
    }
    
    static func getCardValue(card: String) -> Int {
        let position = cards.firstIndex(of: card) ?? -1
        if position >= 9 {
            return 10
        } else {
            return position + 1
        }
    }
    
    private func generateBattleCards(quantityOfDecks: Int = 4) {
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
            printAsTitle("Fim de Batalha")
            print("\n\(player.name) ganhou o jogo com \(player.attributes.health) pontos de vida restantes")
            print("\n\(player.name) recebe R$\(enemy.bounty) de recompensa. Dinheiro total: R$\(player.money)")
            print("\(enemy.name) perdeu o jogo")
            return true
        } else if player.attributes.health <= 0 {
            printAsTitle("Fim de Batalha")
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
                var damage: Int = player.attributes.attackDamage
                if (enemy.cardsTotal > 21) {
                    damage += Int(Double(enemy.cardsTotal - 21) * 1.5)
                } else {
                    damage += player.cardsTotal - enemy.cardsTotal
                }
                if player.cardsTotal == 21 {
                    damage = Int(Double(damage) * player.attributes.criticalMultiplier)
                }
                print("\(enemy.name) perde \(damage) pontos de vida")
                enemy.attributes.health -= damage
            } else if player.cardsTotal < enemy.cardsTotal && enemy.cardsTotal <= 21 || player.cardsTotal > 21 {
                print("\n\(enemy.name) ganhou a rodada")
                var damage: Int = enemy.attributes.attackDamage
                if (player.cardsTotal > 21) {
                    damage += Int(Double(player.cardsTotal - 21) * 1.5)
                } else {
                    damage += enemy.cardsTotal - player.cardsTotal
                }
                if enemy.cardsTotal == 21 {
                    damage = Int(Double(damage) * enemy.attributes.criticalMultiplier)
                }
                print("\(player.name) perde \(damage) pontos de vida")
                player.attributes.health -= damage
            } else {
                print("\nRodada empatou")
            }
            player.printAttributes()
            enemy.printAttributes()
            pressEnterToContinue()
            return true
        }
        return false
    }
    
    private func startNewRound() {
        printAsTitle("Começando nova rodada")
        dealInitialHands(from: &battleCards, for: [player, enemy])
        player.printHandAndCardsTotal()
        player.printAttributes()
        enemy.printHandAndCardsTotal()
        enemy.printAttributes()
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
    
    func startNewBattle(player: Player, enemy: Enemy) {
        generateBattleCards()
        self.player = player
        self.enemy = enemy
        currentTurn = 0
        printAsTitle("Começando a Batalha")
        print("\nInimigo: \(enemy.name). Recompensa: R$\(enemy.bounty)")
        enemy.printAttributes()
        pressEnterToContinue()
        manageBattle()
    }
}
