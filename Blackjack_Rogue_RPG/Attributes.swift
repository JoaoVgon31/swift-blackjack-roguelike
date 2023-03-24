//
//  Attributes.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 21/03/23.
//

import Foundation

class Attributes {
    private var _health: Int = 0
    private var _maxHealth: Int = 0
    private var _chips: Int = 0
    private var _maxChips: Int = 0
    private var _attackDamage: Int = 0
    private var _criticalMultiplier: Double = 0.0
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
    var chips: Int {
        get { _chips }
        set {
            if newValue >= _maxChips {
                _chips = _maxChips
            } else {
                _chips = newValue
            }
        }
    }
    var maxChips: Int {
        get { _maxChips }
        set { _maxChips = newValue }
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
        self.health = 0
        self.maxHealth = 0
        self.chips = 0
        self.maxChips = 0
        self.attackDamage = 0
        self.criticalMultiplier = 0.0
    }
    
    init(maxHealth: Int, maxChips: Int, attackDamage: Int, criticalMultiplier: Double) {
        self.maxHealth = maxHealth
        self.health = maxHealth
        self.maxChips = maxChips
        self.chips = maxChips
        self.attackDamage = attackDamage
        self.criticalMultiplier = criticalMultiplier
    }
}
