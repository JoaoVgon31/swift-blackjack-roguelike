//
//  Map.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Map {
    func generateMap(paths: Int = 3, floors: Int = 5) {
        let superiorLimit = {
            var buildingLimit = "_"
            for _ in 1...paths {
                buildingLimit += "___"
            }
            return buildingLimit + "_"
        }()
        
        let inferiorLimit = {
            var buildingLimit = "|"
            for _ in 1...paths {
                buildingLimit += "___"
            }
            return buildingLimit + "|"
        }()
        
        let emptyFloor = {
            var buildingFloor = "|"
            for _ in 1...paths {
                buildingFloor += "   "
            }
            return buildingFloor + "|"
        }()
        
        let floor = {
            var buildingFloor = "|"
            for _ in 1...paths {
                buildingFloor += " # "
            }
            return buildingFloor + "|"
        }()
        
        print(superiorLimit)
        for _ in 1...floors {
            print(emptyFloor)
            print(floor)
        }
        print(inferiorLimit)
    }
}
