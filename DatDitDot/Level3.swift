import SpriteKit

class Level3: Level {
    
    override init() {
        super.init()
        
        // Setup level
        self.number = 3
        self.goals = [1, 2, 3]
        self.moves = 3
        
        // Setup board
        piecesHigh = 3
        piecesWide = 3
        sideLength = 80.0
        let facial = true
        let row2 = [Dit(sideLength: sideLength, row: 2, col: 0, color: PieceColor.Red, facialFeatures: facial),
                    Dat(sideLength: sideLength, row: 2, col: 1, color: PieceColor.Red, facialFeatures: facial),
                    Dit(sideLength: sideLength, row: 2, col: 2, color: PieceColor.Red, facialFeatures: facial)]
        let row1 = [Dat(sideLength: sideLength, row: 1, col: 0, color: PieceColor.Yellow, facialFeatures: facial),
                    Dat(sideLength: sideLength, row: 1, col: 1, color: PieceColor.Green, facialFeatures: facial),
                    Dat(sideLength: sideLength, row: 1, col: 2, color: PieceColor.Yellow, facialFeatures: facial)]
        let row0 = [Dot(sideLength: sideLength, row: 0, col: 0, color: PieceColor.Red, facialFeatures: facial),
                    Dat(sideLength: sideLength, row: 0, col: 1, color: PieceColor.Red, facialFeatures: facial),
                    Dot(sideLength: sideLength, row: 0, col: 2, color: PieceColor.Red, facialFeatures: facial)]


        board.append(row0)
        board.append(row1)
        board.append(row2)
        
        // Setup objectives
        var levelObjectives = [Objective]()
        levelObjectives.append(Objective(color: PieceColor.Green, number: 4, pieceType: PieceType.Dat))
        self.levelObjectives = LevelObjectives(objectives: levelObjectives)
        
        // Set current state
        self.currentState = getCurrentState()
    }
}