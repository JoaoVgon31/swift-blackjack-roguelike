//
//  Map.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Map {
    var content: Array<Array<String>> = []
    
    init(paths: Int, floors: Int) {
        self.content = Map.generateMapContent(paths: paths, floors: floors)
    }
    
    private static func generateMapContent(paths: Int, floors: Int) -> Array<Array<String>> {
        var mapContent: Array<Array<String>> = []
        
        for floor in 0..<floors {
            mapContent.append([])
            for path in 0..<paths {
                if floor == 0 {
                    mapContent[floor].append("\(path + 1)")
                }
            }
        }
        
        return mapContent
    }
    
    func printMap() {
        let floors = map.content.count
        let paths = map.content[0].count
        
        let superiorLimit = {
            var buildingLimit = "           _"
            for _ in 1...paths {
                buildingLimit += "___"
            }
            return buildingLimit + "_"
        }()
        
        let inferiorLimit = {
            var buildingLimit = "           |"
            for _ in 1...paths {
                buildingLimit += "___"
            }
            return buildingLimit + "|"
        }()
        
        let emptyFloor = {
            var buildingFloor = "           |"
            for _ in 1...paths {
                buildingFloor += "   "
            }
            return buildingFloor + "|"
        }()
        
        let floor = {
            var buildingFloor = "           |"
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
