import SpriteKit
import Foundation

class LevelObjectives {
    let objectives: [Objective]
    let objectiveDict: [PieceTypeColor : Int]
    
    init(objectives: [Objective]) {
        self.objectives = objectives
        self.objectiveDict = LevelObjectives.buildObjectivesDict(self.objectives)
    }
    
    class func buildObjectivesDict(objectives: [Objective]) -> [PieceTypeColor: Int]{
        var dict = [PieceTypeColor : Int]()
        for type in PieceType.allValues {
            for color in PieceColor.allValues {
                dict[PieceTypeColor(type: type, color: color)] = 0
            }
        }
        for objective in objectives {
            dict[PieceTypeColor(type: objective.type, color: objective.color)]! += objective.number
        }
        return dict
    }
}