import SpriteKit

class Level2: Level {
    
    override init() {
        
        super.init()
        
        // Setup level
        self.number = 2

        // Setup board
        piecesHigh = 3
        piecesWide = 3
        halfSideLength = 40.0
        let facial = true
        let row0 = [Dit(sideLength: halfSideLength, row: 0, col: 0, color: PieceColor.Green, facialFeatures: facial),
                    Dot(sideLength: halfSideLength, row: 0, col: 1, color: PieceColor.Green, facialFeatures: facial),
                    Dit(sideLength: halfSideLength, row: 0, col: 2, color: PieceColor.Green, facialFeatures: facial)]
        let row1 = [Dat(sideLength: halfSideLength, row: 1, col: 0, color: PieceColor.Yellow, facialFeatures: facial),
                    Dit(sideLength: halfSideLength, row: 1, col: 1, color: PieceColor.Yellow, facialFeatures: facial),
                    Dat(sideLength: halfSideLength, row: 1, col: 2, color: PieceColor.Yellow, facialFeatures: facial)]
        let row2 = [Dat(sideLength: halfSideLength, row: 2, col: 0, color: PieceColor.Blue, facialFeatures: facial),
                    Dit(sideLength: halfSideLength, row: 2, col: 1, color: PieceColor.Blue, facialFeatures: facial),
                    Dat(sideLength: halfSideLength, row: 2, col: 2, color: PieceColor.Blue, facialFeatures: facial)]
        board.append(row0)
        board.append(row1)
        board.append(row2)
        
        // Setup objectives
        var levelObjectives = [Objective]()
        levelObjectives.append(Objective(color: PieceColor.Yellow, number: 4, pieceType: PieceType.Dit))
        self.levelObjectives = LevelObjectives(objectives: levelObjectives)
        
        // Set moves
        moves = 3
        
        // Set current state
        self.currentState = getCurrentState()
    }
}