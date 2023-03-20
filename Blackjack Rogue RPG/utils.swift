//
//  util.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

enum InputError: Error {
    case invalid
    case NAN
}

func readInt() throws -> Int {
    if let input = readLine() {
        if let intInput = Int(input) {
            return intInput
        } else {
            throw InputError.NAN
        }
    } else {
        throw InputError.invalid
    }
}

func readIntInClosedRange(range: ClosedRange<Int>) -> Int {
    while true {
        if let input = try? readInt() {
            if range.contains(input) {
                return input
            }
        }
    }
}
