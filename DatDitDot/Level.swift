import SpriteKit
import Foundation

class Level {
    var piecesWide: Int
    var piecesHigh: Int
    var moves: Int
    var number: Int
    var board: [[BaseD]]
    var levelObjectives: LevelObjectives
    var halfSideLength: CGFloat
    var currentState: [PieceTypeColor: Int]
    
    init() {
        self.board = [[BaseD]]()
        self.levelObjectives = LevelObjectives(objectives: [Objective]())
        self.piecesWide = 0
        self.piecesHigh = 0
        self.moves = 0
        self.halfSideLength = 0.0
        self.number = 0
        self.currentState = [PieceTypeColor: Int]()
    }
    
    func checkWin() -> Bool {
        for type in PieceType.allValues {
            for color in PieceColor.allValues {
                let key = PieceTypeColor(type: type, color: color)
                if levelObjectives.objectiveDict[key] > self.currentState[key] {
                    return false
                }
            }
        }
        return true
    }
    
    func getCurrentState() -> [PieceTypeColor: Int] {
        var currentDict = [PieceTypeColor: Int]()
        for type in PieceType.allValues {
            for color in PieceColor.allValues {
                currentDict[PieceTypeColor(type: type, color: color)] = 0
            }
        }
        for nodeArr in board {
            for node in nodeArr {
                currentDict[PieceTypeColor(type: node.type, color: node.color)]!++
            }
        }
        return currentDict
    }
    
    func hasNoMoves() -> Bool {
        let firstColor = board[0][0].color
        for nodeArr in board {
            for node in nodeArr {
                if node.color == firstColor {
                    continue
                }
                return false
            }
        }
        return true
    }
    
    class func CreateLevel(level: Int) -> Level {
        switch(level) {
            case 1:
                return Level1()
            case 2:
                return Level2()
            case 3:
                return Level3()
            case 4:
                return Level10()
            case 10:
                return Level10()
            default:
                println("No level number \(level), returning level 1")
                return Level1()
        }
    }
}