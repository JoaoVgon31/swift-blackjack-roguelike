//
//  GameController.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 22/03/23.
//

import Foundation

class GameController {
    var player: Player
    var battleTable: BattleTable
    var map: Map
    
    init(paths: Int, floors: Int) {
        self.player = Player(attributes: Attributes(health: 30, attackDamage: 4, criticalMultiplier: 2.0), money: 20)
        self.battleTable = BattleTable()
        self.map = Map(paths: paths, floors: floors)
    }
    
    private func generateEnemy(difficultyModifier: Int) -> Enemy {
        let health = 20 + difficultyModifier * Int.random(in: 1...3)
        let attackDamage = 1 + difficultyModifier * Int.random(in: 0...1)
        let criticalMultiplier = 1.0 + Double(difficultyModifier * Int.random(in: 1...3)) / 10.0
        let bounty = 5 + difficultyModifier * Int.random(in: 5...10)
        return Enemy(name: "Inimigo", attributes: Attributes(health: health, attackDamage: attackDamage, criticalMultiplier: criticalMultiplier), bounty: bounty)
    }
    
    func manageGame() {
        printAsTitle("Começando o Jogo")
        print("""
              \nVocê começa na parte inferior do mapa
              e precisa subir até o topo enfrentando
              inimigos, #, ao longo do caminho
              """)
        pressEnterToContinue()
        
        while map.currentFloor < 9 && player.attributes.health > 0 {
            let location = map.goToNextFloor()
            pressEnterToContinue()
            
            switch location {
            case Map.Locations.Enemy:
                battleTable.startNewBattle(player: player, enemy: generateEnemy(difficultyModifier: map.currentFloor))
            case Map.Locations.RestPlace:
                printAsTitle("Local de Descanso")
                player.printAttributes()
                print("\nSelecione uma das opções:\n1.Descansar (Recuperar 30% pontos de vida)2.Sair")
                let selectedOption = readIntInClosedRange(range: 1...2)
                if selectedOption == 1 {
                    let recoveredHealth = Int(Double(player.attributes.maxHealth) * 0.3)
                    player.attributes.health += recoveredHealth
                    print("Você recuperou \(recoveredHealth). Vida atual: \(player.attributes.health)")
                } else if selectedOption == 2 {
                    continue
                }
            default:
                continue
            }
        }
        
        map.updateMap()
        map.printMap()
        printAsTitle("Fim de Jogo")
    }
}
