//
//  Map.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Map {
    enum Locations {
        case Enemy
        case RestPlace
        case Merchant
        case RandomEvent
        case Empty
    }
    static let locationsSymbol = [Locations.Enemy: "#", Locations.RestPlace: "~", Locations.Merchant: "$", Locations.RandomEvent: "?"]
    static let symbolsLocation = ["#": Locations.Enemy, "~": Locations.RestPlace, "$": Locations.Merchant, "?": Locations.RandomEvent]
    var content: Array<Array<String>> = []
    var lastPathTraveled: Int = -1
    var currentFloor: Int = -1
    
    init(paths: Int, floors: Int) {
        self.content = Map.generateMapContent(paths: paths, floors: floors)
    }
    
    private static func generateMapContent(paths: Int, floors: Int) -> Array<Array<String>> {
        var mapContent: Array<Array<String>> = []
        let restPlacesPosition = {() -> Array<Int> in
            var positions: Array<Int> = []
            var nextPositionMinFloor = 3
            let maxPositions = floors / 2
            for _ in 0..<maxPositions {
                nextPositionMinFloor = Int.random(in: nextPositionMinFloor...(nextPositionMinFloor + 3))
                positions.append(nextPositionMinFloor - 1)
                nextPositionMinFloor += 3
            }
            return positions
        }()
        
        var restPlacesCount = 0
        var restPlacePath = 0
        for floor in 0..<floors {
            mapContent.append([])
            if floor == restPlacesPosition[restPlacesCount] {
                restPlacePath = Int.random(in: 0...2)
            }
            for path in 0..<paths {
                if floor == restPlacesPosition[restPlacesCount] && path == restPlacePath {
                    mapContent[floor].append(locationsSymbol[Locations.RestPlace]!)
                    restPlacesCount += 1
                } else {
                    mapContent[floor].append("#")
                }
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
    
    func goToNextFloor() -> Locations {
        updateMap()
        printMap()
        let path = readNextFloorPath()
        let pathSymbol = content[currentFloor][path - 1]
        if let pathLocation = Map.symbolsLocation[pathSymbol] {
            return pathLocation
        }
        return Locations.Empty
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
