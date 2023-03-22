//
//  Map.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Map {
    enum locations {
        case Enemy
        case RestPlace
        case Merchant
        case RandomEvent
    }
    static let locationsSymbol = [locations.Enemy: "#", locations.RestPlace: "~", locations.Merchant: "$", locations.RandomEvent: "?"]
    var content: Array<Array<String>> = []
    var lastPathTraveled: Int = -1
    var currentFloor: Int = -1
    
    init(paths: Int, floors: Int) {
        self.content = Map.generateMapContent(paths: paths, floors: floors)
    }
    
    private static func generateMapContent(paths: Int, floors: Int) -> Array<Array<String>> {
        var mapContent: Array<Array<String>> = []
        
        for floor in 0..<floors {
            mapContent.append([])
            for _ in 0..<paths {
                mapContent[floor].append("#")
            }
        }
        
        return mapContent
    }
    
    func updateMap() {
        let floors = content.count
        let paths = content[0].count
        
        for floor in 0..<floors {
            if floor == currentFloor {
                for path in 0..<paths {
                    if path == lastPathTraveled - 1 {
                        content[floor][path] = "X"
                    } else {
                        content[floor][path] = "#"
                    }
                }
            }
            else if floor == currentFloor + 1 {
                for path in 0..<paths {
                    content[floor][path] = "\(path + 1)"
                }
            }
        }
        
        currentFloor += 1
    }
    
    func readNextFloorPath() -> Int {
        print("\nSelecione um dos caminhos para seguir: 1 | 2 | 3")
        let selectedOption = readIntInClosedRange(range: 1...3)
        lastPathTraveled = selectedOption
        return selectedOption
    }
    
    func goToNextFloor() {
        updateMap()
        printMap()
        let _ = readNextFloorPath()
    }
    
    func printMap() {
        let floors = content.count
        let paths = content[0].count
        
        let superiorLimit = {
            var buildingLimit = "           _"
            for _ in 0..<paths {
                buildingLimit += "___"
            }
            return buildingLimit + "_"
        }()
        
        let inferiorLimit = {
            var buildingLimit = "           |"
            for _ in 0..<paths {
                buildingLimit += "___"
            }
            return buildingLimit + "|"
        }()
        
        let emptyFloor = {
            var buildingFloor = "           |"
            for _ in 0..<paths {
                buildingFloor += "   "
            }
            return buildingFloor + "|"
        }()
        
        let generateFloor = { (number: Int) in
            var buildingFloor = "           |"
            for path in 0..<paths {
                buildingFloor += " \(self.content[number][path]) "
            }
            return buildingFloor + "|"
        }
        
        print(superiorLimit)
        for floor in stride(from: floors - 1, through: 0, by: -1) {
            print(emptyFloor)
            print(generateFloor(floor))
        }
        print(inferiorLimit)
    }
}
