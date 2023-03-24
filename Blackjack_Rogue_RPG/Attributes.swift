//
//  Attributes.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 21/03/23.
//

import Foundation

class Attributes {
    private var _health: Int = 1
    private var _maxHealth: Int = 1
    private var _attackDamage: Int = 1
    private var _criticalMultiplier: Double = 1.0
    var health: Int {
        get { _health }
        set {
            if newValue >= _maxHealth {
                _health = _maxHealth
            } else {
                _health = newValue
            }
        }
    }
    var maxHealth: Int {
        get { _maxHealth }
        set { _maxHealth = newValue }
    }
    var attackDamage: Int {
        get { _attackDamage }
        set { _attackDamage = newValue }
    }
    var criticalMultiplier: Double {
        get { _criticalMultiplier }
        set { _criticalMultiplier = newValue }
    }
    
    init() {
        self.health = 30
        self.maxHealth = 30
        self.attackDamage = 4
        self.criticalMultiplier = 1.1
    }
    
    init(maxHealth: Int, attackDamage: Int, criticalMultiplier: Double) {
        self.maxHealth = maxHealth
        self.health = maxHealth
        self.attackDamage = attackDamage
        self.criticalMultiplier = criticalMultiplier
    }
}
