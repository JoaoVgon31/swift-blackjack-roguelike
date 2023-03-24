//
//  Stack.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 24/03/23.
//

import Foundation

struct Queue<Element> {
    private var items: Array<Element> = []
    
    mutating func enqueue(_ item: Element) {
        items.append(item)
    }
    
    mutating func dequeue() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        return items.removeFirst()
    }
    
    var head: Element? {
        return items.first
    }
    
    var tail: Element? {
        return items.last
    }
    
}
