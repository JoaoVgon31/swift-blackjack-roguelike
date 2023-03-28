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
    
    private func giveGamblePrize(to character: Character, from gambles: inout Queue<GamblingEffectCard>, activateGambleEffect: Bool = false) {
        while true {
            guard let effectCard = gambles.dequeue() else {
                break
            }
            character.attributes.chips += effectCard.cost
            if activateGambleEffect {
                print(effectCard.effect(character))
            }
        }
    }
    
    private func battleEnded() -> Bool {
        if enemy.attributes.health <= 0 {
            printAsTitle("Fim de Batalha")
            print("\n\(player.name) ganhou a batalha com \(player.attributes.health) pontos de vida restantes")
            player.money += enemy.bounty
            print("\n\(player.name) recebe R$\(enemy.bounty) de recompensa. Dinheiro total: R$\(player.money)")
            print("\(enemy.name) perdeu a batalha")
            return true
        } else if player.attributes.health <= 0 {
            printAsTitle("Fim de Batalha")
            print("\n\(enemy.name) ganhou a batalha com \(enemy.attributes.health) pontos de vida restantes")
            print("\(player.name) perdeu a batalha")
            return true
        }
        return false
    }
    
    private func roundEnded() -> Bool {
        if player.stopped && enemy.stopped || player.cardsTotal > 21 || enemy.cardsTotal > 21 {
            printAsTitle("Fim da Rodada")
            if player.cardsTotal > enemy.cardsTotal && player.cardsTotal <= 21 || enemy.cardsTotal > 21 {
                endRound(winner: player, loser: enemy)
            } else if player.cardsTotal < enemy.cardsTotal && enemy.cardsTotal <= 21 || player.cardsTotal > 21 {
                endRound(winner: enemy, loser: player)
            } else {
                giveGamblePrize(to: player, from: &player.gambleQueue)
                giveGamblePrize(to: enemy, from: &enemy.gambleQueue)
                print("\nRodada empatou")
            }
            player.printAttributes()
            enemy.printAttributes()
            pressEnterToContinue()
            return true
        }
        return false
    }
    
    private func endRound(winner: Character, loser: Character) {
        print("\n\(winner.name) ganhou a rodada")
        giveGamblePrize(to: winner, from: &winner.gambleQueue, activateGambleEffect: true)
        giveGamblePrize(to: winner, from: &loser.gambleQueue)
        var damage: Int = winner.attributes.attackDamage + winner.battleAttributes.attackDamage + winner.temporaryAttributes.attackDamage
        if (loser.cardsTotal > 21) {
            damage += Int(Double(loser.cardsTotal - 21) * 1.5)
        } else {
            damage += winner.cardsTotal - loser.cardsTotal
        }
        if winner.cardsTotal == 21 {
            damage = Int(Double(damage) * winner.attributes.criticalMultiplier)
        }
        damage -= loser.attributes.armor + loser.battleAttributes.armor + loser.temporaryAttributes.armor
        print("\(loser.name) perde \(damage) pontos de vida")
        loser.attributes.health -= damage
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
        if character.attributes.chips < 5 {
            character.attributes.chips = 5
        }
        character.effectCardsDiscardPile += character.effectCardsHand
        character.effectCardsHand.removeAll()
        while character.effectCardsHand.count < 5 {
            if character.effectCards.isEmpty {
                character.effectCards = character.effectCardsDiscardPile
                character.effectCardsDiscardPile.removeAll()
            }
            let randomEffectCard = character.effectCards.remove(at: Int.random(in: 0..<character.effectCards.count))
            character.effectCardsHand.append(randomEffectCard)
        }
        character.temporaryAttributes.reset()
        var oponentCardsTotal: Int
        if let _ = character as? Player {
            oponentCardsTotal = enemy.cardsTotal
        } else {
            oponentCardsTotal = player.cardsTotal
        }
        character.makePlay(battleCards: &battleCards, oponentCardsTotal: oponentCardsTotal)
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
