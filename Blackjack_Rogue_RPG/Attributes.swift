//
//  Attributes.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 21/03/23.
//

import Foundation

struct Attributes {
    var health: Int
    var maxHealth: Int
    var attackDamage: Int
    var criticalMultiplier: Double
    
    init(health: Int, attackDamage: Int, criticalMultiplier: Double) {
        self.health = health
        self.maxHealth = health
        self.attackDamage = attackDamage
        self.criticalMultiplier = criticalMultiplier
    }
}
