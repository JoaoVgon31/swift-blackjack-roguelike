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
    guard let input = readLine() else {
        throw InputError.NAN
    }
    guard let intInput = Int(input) else {
        throw InputError.invalid
    }
    return intInput
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

func pressEnterToContinue() {
    print("\nPressione enter/return para continuar")
    let _ = readLine()
}

func printAsTitle(_ message: String) {
    print("\n_______________\(message.uppercased())_______________")
}

func printOptions(withTitle title: String = "Selecione uma das opções", _ options: String...) {
    print("\n\(title):")
    var optionNumber = 1
    for option in options {
        print("\(optionNumber).\(option)")
        optionNumber += 1
    }
}
