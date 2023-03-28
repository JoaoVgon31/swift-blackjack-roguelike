//
//  Location.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 23/03/23.
//

import Foundation

protocol Location {
    var symbol: String { get }
    var name: String { get }
    func playerWillEnter(player: Player)
    func playerDidEnter(player: Player)
    func playerWillLeave(player: Player)
}

extension Location {
    func playerWillEnter(player: Player) {
        printAsTitle("Entrando em \(name)")
        pressEnterToContinue()
    }
    
    func playerWillLeave(player: Player) {
        printAsTitle("Saindo de \(name)")
        pressEnterToContinue()
    }
}

class EnemyEncounter: Location {
    static var battleTable: BattleTable = BattleTable()
    var symbol: String = "#"
    var name: String = "Mesa de Batalha"
    var enemy: Enemy = Enemy()
    
    init(floor: Int) {
        self.enemy = GameController.generateEnemy(difficultyModifier: floor)
    }
    
    func playerDidEnter(player: Player) {
        EnemyEncounter.battleTable.startNewBattle(player: player, enemy: enemy)
    }
}

class RestSite: Location {
    var symbol: String = "˜"
    var name: String = "Local de Descanso"
    
    func playerDidEnter(player: Player) {
        printAsTitle("Local de Descanso")
        player.printAttributes()
        printOptions("Descansar (Recuperar 30% pontos de vida)", "Sair")
        let selectedOption = readIntInClosedRange(range: 1...2)
        if selectedOption == 1 {
            let recoveredHealth = Int(Double(player.attributes.maxHealth) * 0.3)
            player.attributes.health += recoveredHealth
            print("Você recuperou \(recoveredHealth). Vida atual: \(player.attributes.health)")
        } else if selectedOption == 2 {
            return
        }
    }
}

class Cleared: Location {
    var symbol: String = "X"
    var name: String = "Cleared"
    
    func playerDidEnter(player: Player) {
        return
    }
}
