//
//  main.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

let mapPaths = 3
let mapFloors = 12
let playerHealth = 40
let playerAttackDamage = 5
let playerCriticalMultiplier = 2.0
let playerMoney = 20

var gameController = GameController(mapPaths: mapPaths, mapFloors: mapFloors, playerAttributes: Attributes(health: playerHealth, attackDamage: playerAttackDamage, criticalMultiplier: playerCriticalMultiplier), playerMoney: playerMoney)
gameController.manageGame()
