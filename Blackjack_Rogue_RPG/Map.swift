//
//  Map.swift
//  Blackjack Rogue RPG
//
//  Created by João Vitor Gonçalves Oliveira on 20/03/23.
//

import Foundation

class Map {
    private var _content: Array<Array<Location>> = []
    private var _lastChoosenPath: Int = -1
    private var _currentFloor: Int = -1
    var content: Array<Array<Location>> {
        get { _content }
        set { _content = newValue }
    }
    var lastChoosenPath: Int {
        get { _lastChoosenPath }
        set {
            if newValue >= 1 && newValue <= 3 {
                _lastChoosenPath = newValue
            }
        }
    }
    var currentFloor: Int {
        get { _currentFloor }
        set { _currentFloor = newValue }
    }
    
    init() {
        self.content = []
    }
    
    init(paths: Int, floors: Int) {
        self.content = Map.generateMapContent(paths: paths, floors: floors)
    }
    
    private static func generateMapContent(paths: Int, floors: Int) -> Array<Array<Location>> {
        var mapContent: Array<Array<Location>> = []
        let restPlacesPosition = {() -> Array<Int> in
            var positions: Array<Int> = []
            var nextPositionMinFloor = 3
            var position = 0
            while nextPositionMinFloor < 12  {
                position = Int.random(in: nextPositionMinFloor...(nextPositionMinFloor + 2))
                if position < floors {
                    positions.append(position - 1)
                }
                nextPositionMinFloor = position + 3
            }
            return positions
        }()
        
        var restPlacePath = 0
        for floor in 0..<floors {
            mapContent.append([])
            if restPlacesPosition.contains(floor) {
                restPlacePath = Int.random(in: 0...2)
            }
            for path in 0..<paths {
                if restPlacesPosition.contains(floor) && path == restPlacePath {
                    mapContent[floor].append(RestSite())
                } else {
                    mapContent[floor].append(EnemyEncounter(floor: floor))
                }
            }
        }
        
        return mapContent
    }
    
    private func readNextFloorPath() -> Int {
        let currentFloorContent = content[currentFloor]
        var pathOptions: Array<String> = []
        for path in 0..<currentFloorContent.count {
            pathOptions.append(currentFloorContent[path].name)
        }
        printOptions(withTitle: "Selecione um dos caminhos para seguir", pathOptions)
        let selectedOption = readIntInClosedRange(range: 1...3)
        lastChoosenPath = selectedOption
        return selectedOption
    }
    
    func goToNextFloor() -> Location {
        updateMap()
        printMap()
        let path = readNextFloorPath()
        return content[currentFloor][path - 1]
    }
    
    func updateMap() {
        if currentFloor >= 0 {
            content[currentFloor][lastChoosenPath - 1] = Cleared()
        }
        currentFloor += 1
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
        
        let generateEmptyFloor = { (floor: Int) in
            var buildingFloor = "           |"
            if floor == self.currentFloor {
                for path in 0..<paths {
                    buildingFloor += " \(path + 1) "
                }
            } else {
                for _ in 0..<paths {
                    buildingFloor += "   "
                }
            }
            return buildingFloor + "|"
        }
        
        let generateLocationsFloor = { (floor: Int) in
            var buildingFloor = ""
            if floor == self.currentFloor {
                buildingFloor += "---------->|"
            } else {
                buildingFloor += "           |"
            }
            for path in 0..<paths {
                buildingFloor += " \(self.content[floor][path].symbol) "
            }
            return buildingFloor + "|"
        }
        
        print(superiorLimit)
        for floor in stride(from: floors - 1, through: 0, by: -1) {
            print(generateEmptyFloor(floor))
            print(generateLocationsFloor(floor))
        }
        print(inferiorLimit)
    }
}
