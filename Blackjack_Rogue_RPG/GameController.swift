//
//  GameController.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 22/03/23.
//

import Foundation

class GameController {
    private var _player: Player = Player()
    private var _map: Map = Map()
    var player: Player {
        get { _player }
        set { _player = newValue }
    }
    var map: Map {
        get { _map }
        set { _map = newValue }
    }
    
    init(mapPaths: Int, mapFloors: Int, playerAttributes: Attributes, playerMoney: Int) {
        self.player = Player(attributes: playerAttributes, money: playerMoney)
        self.map = Map(paths: mapPaths, floors: mapFloors)
    }
    
    static func generateEnemy(difficultyModifier: Int) -> Enemy {
        let health = 10 + difficultyModifier * Int.random(in: 1...8)
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
        
        while map.currentFloor < map.content.count && player.attributes.health > 0 {
            let location = map.goToNextFloor()
            location.playerWillEnter(player: player)
            location.playerDidEnter(player: player)
            location.playerWillLeave(player: player)
        }
        
        if (player.attributes.health > 0) {
            map.updateMap()
            map.printMap()
        }
        printAsTitle("Fim de Jogo")
    }
}
