//
//  main.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

var map = Map(paths: 3, floors: 10)
printAsTitle("Mapa")
print("""
      \nYou, X, start at the bottom of the map
      and need to climb to the top fighting
      against enemies, #, through the way
      """)
map.printMap()

//var battleTable = BattleTable()
//battleTable.startNewBattle()
