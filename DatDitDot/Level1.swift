import SpriteKit

class Level1: Level {
    
    override init() {
        super.init()
        
        // Setup level
        self.number = 1
        self.goals = [1, 2, 3]
        self.moves = 3
        
        // Setup board
        piecesHigh = 3
        piecesWide = 3
        sideLength = 80.0

        let facial = true
        let row0 = [Dit(sideLength: sideLength, row: 0, col: 0, color: PieceColor.Green, facialFeatures: facial),
                    Dot(sideLength: sideLength, row: 0, col: 1, color: PieceColor.Green, facialFeatures: facial),
                    Dat(sideLength: sideLength, row: 0, col: 2, color: PieceColor.Green, facialFeatures: facial)]
        let row1 = [Dit(sideLength: sideLength, row: 1, col: 0, color: PieceColor.Red, facialFeatures: facial),
                    Dot(sideLength: sideLength, row: 1, col: 1, color: PieceColor.Red, facialFeatures: facial),
                    Dat(sideLength: sideLength, row: 1, col: 2, color: PieceColor.Red, facialFeatures: facial)]
        let row2 = [Dit(sideLength: sideLength, row: 2, col: 0, color: PieceColor.Blue, facialFeatures: facial),
                    Dot(sideLength: sideLength, row: 2, col: 1, color: PieceColor.Blue, facialFeatures: facial),
                    Dat(sideLength: sideLength, row: 2, col: 2, color: PieceColor.Blue, facialFeatures: facial)]
        board.append(row0)
        board.append(row1)
        board.append(row2)
        
        // Setup objectives
        var levelObjectives = [Objective]()
        levelObjectives.append(Objective(color: PieceColor.Red, number: 3, pieceType: PieceType.Dot))
        levelObjectives.append(Objective(color: PieceColor.Red, number: 3, pieceType: PieceType.Dat))
        levelObjectives.append(Objective(color: PieceColor.Red, number: 3, pieceType: PieceType.Dit))
        self.levelObjectives = LevelObjectives(objectives: levelObjectives)
        
        // Set current state
        self.currentState = getCurrentState()
    }
}