//
//  main.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

// Map Size
let mapPaths = 3
let mapFloors = 12

// Player Attributes
let playerMaxHealth = 40
let playerMaxChips = 30
let playerAttackDamage = 5
let playerCriticalMultiplier = 2.0
let playerMoney = 20

// Effect Cards
enum EffectCardText {
    case attackGamble(name: String, effectDescription: String)
    case temporaryArmor(name: String, effectDescription: String)
    
    func getText(withEffectDescription: Bool = true) -> String {
        switch self {
        case .attackGamble(let name, let effectDescription):
            return "\(name)" + (withEffectDescription ? ": \(effectDescription)" : "")
        case .temporaryArmor(let name, let effectDescription):
            return "\(name)" + (withEffectDescription ? ": \(effectDescription)" : "")
        }
    }
}

var attackGamble = GamblingEffectCard(
    text: .attackGamble(name: "Aposta de Ataque", effectDescription: "+3 de ataque"),
    cost: 5,
    effect: { (character: Character) -> String in
        character.temporaryAttributes.attackDamage += 3
        return "\(character.name) venceu Aposta de Ataque: +3 de ataque"
    }
)
var temporaryArmor = ConsumableEffectCard(
    text: .temporaryArmor(name: "Armadura Temporária", effectDescription: "Ganhe 3 de armadura neste turno"),
    cost: 5,
    effect: { (character: Character) -> String in
        character.temporaryAttributes.armor += 3
        return "\(character.name) usou Armadura Temporária: +3 de armadura"
    }
)

// Player Effect Cards
var playerEffectCards: Array<EffectCard> = {
    var effectCards: Array<EffectCard> = []
    for _ in 1...5 {
        effectCards.append(attackGamble)
        effectCards.append(temporaryArmor)
    }
    return effectCards
}()

var gameController = GameController(mapPaths: mapPaths, mapFloors: mapFloors, playerAttributes: Attributes(maxHealth: playerMaxHealth, maxChips: playerMaxChips, attackDamage: playerAttackDamage, criticalMultiplier: playerCriticalMultiplier), playerMoney: playerMoney, playerEffectCards: playerEffectCards)
gameController.manageGame()
