//
//  Card.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 23/03/23.
//

import Foundation

protocol EffectCard {
    var name: String { get set }
    var cost: Int { get set }
    var effect: (Character) -> String { get set }
    func use(from character: Character)
}

class GamblingEffectCard: EffectCard {
    var name: String
    var cost: Int
    var effect: (Character) -> String
    
    init(name: String, cost: Int, effect: @escaping (Character) -> String) {
        self.name = name
        self.cost = cost
        self.effect = effect
    }
    
    func use(from character: Character) {
        if character.attributes.chips >= cost {
            character.attributes.chips -= cost
            character.gambleQueue.enqueue(self)
        } else {
            print("\nVocê não possui fichas suficientes")
        }
    }
}

class ConsumableEffectCard: EffectCard {
    var name: String
    var cost: Int
    var effect: (Character) -> String
    
    init(name: String, cost: Int, effect: @escaping (Character) -> String) {
        self.name = name
        self.cost = cost
        self.effect = effect
    }
    
    func use(from character: Character) {
        if character.attributes.chips >= cost {
            character.attributes.chips -= cost
            print(effect(character))
        } else {
            print("\nVocê não possui fichas suficientes")
        }
    }
}
