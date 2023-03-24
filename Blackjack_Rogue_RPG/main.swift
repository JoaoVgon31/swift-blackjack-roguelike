//
//  main.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

// Map Size
let mapPaths = 3
let mapFloors = 6

// Player Attributes
let playerMaxHealth = 40
let playerMaxChips = 30
let playerAttackDamage = 5
let playerCriticalMultiplier = 2.0
let playerMoney = 20

// Effect Cards
var attackGamble = GamblingEffectCard(
    name: "Aposta de Ataque: +2 de ataque",
    cost: 5,
    effect: { (character: Character) -> String in
        character.temporaryAttributes.attackDamage += 2
        return "Venceu Aposta de Ataque: +2 de ataque"
    }
)

// Player Effect Cards
var playerEffectCards: Array<EffectCard> = {
    var effectCards: Array<EffectCard> = []
    for _ in 1...5 {
        effectCards.append(attackGamble)
    }
    return effectCards
}()

var gameController = GameController(mapPaths: mapPaths, mapFloors: mapFloors, playerAttributes: Attributes(maxHealth: playerMaxHealth, maxChips: playerMaxChips, attackDamage: playerAttackDamage, criticalMultiplier: playerCriticalMultiplier), playerMoney: playerMoney, playerEffectCards: playerEffectCards)
gameController.manageGame()
