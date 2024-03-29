import SpriteKit

class Level10: Level {
    
    override init() {
        super.init()
        
        // Setup level
        self.number = 10
        self.goals = [1, 5, 10]
        self.moves = 10
        
        // Setup board
        piecesHigh = 4
        piecesWide = 4
        let facial = true
        let row0 = [Dit(sideLength: sideLength, row: 0, col: 0, color: PieceColor.Green, facialFeatures: facial),
            Dot(sideLength: sideLength, row: 0, col: 1, color: PieceColor.Green, facialFeatures: facial),
            Dat(sideLength: sideLength, row: 0, col: 2, color: PieceColor.Green, facialFeatures: facial),
            Dat(sideLength: sideLength, row: 0, col: 3, color: PieceColor.Green, facialFeatures: facial)]
        let row1 = [Dit(sideLength: sideLength, row: 1, col: 0, color: PieceColor.Green, facialFeatures: facial),
            Dot(sideLength: sideLength, row: 1, col: 1, color: PieceColor.Red, facialFeatures: facial),
            Dat(sideLength: sideLength, row: 1, col: 2, color: PieceColor.Green, facialFeatures: facial),
            Dat(sideLength: sideLength, row: 1, col: 3, color: PieceColor.Green, facialFeatures: facial)]
        let row2 = [Dit(sideLength: sideLength, row: 2, col: 0, color: PieceColor.Green, facialFeatures: facial),
            Dot(sideLength: sideLength, row: 2, col: 1, color: PieceColor.Green, facialFeatures: facial),
            Dot(sideLength: sideLength, row: 2, col: 2, color: PieceColor.Green, facialFeatures: facial),
            Dat(sideLength: sideLength, row: 2, col: 3, color: PieceColor.Blue, facialFeatures: facial)]
        let row3 = [Dit(sideLength: sideLength, row: 3, col: 0, color: PieceColor.Green, facialFeatures: facial),
            Dot(sideLength: sideLength, row: 3, col: 1, color: PieceColor.Green, facialFeatures: facial),
            Dat(sideLength: sideLength, row: 3, col: 2, color: PieceColor.Green, facialFeatures: facial),
            Dat(sideLength: sideLength, row: 3, col: 3, color: PieceColor.Green, facialFeatures: facial)]
        board.append(row0)
        board.append(row1)
        board.append(row2)
        board.append(row3)
        
        // Setup objectives
        var levelObjectives = [Objective]()
        levelObjectives.append(Objective(color: PieceColor.Red, number: 3, pieceType: PieceType.Dot))
        levelObjectives.append(Objective(color: PieceColor.Red, number: 3, pieceType: PieceType.Dat))
        levelObjectives.append(Objective(color: PieceColor.Red, number: 3, pieceType: PieceType.Dit))
        levelObjectives.append(Objective(color: PieceColor.Blue, number: 2, pieceType: PieceType.Dot))
        levelObjectives.append(Objective(color: PieceColor.Blue, number: 3, pieceType: PieceType.Dat))
        levelObjectives.append(Objective(color: PieceColor.Blue, number: 1, pieceType: PieceType.Dit))
        //        levelObjectives.append(Objective(color: PieceColor.Yellow, number: 3, pieceType: PieceType.Dot))
        //        levelObjectives.append(Objective(color: PieceColor.Yellow, number: 2, pieceType: PieceType.Dat))
        //        levelObjectives.append(Objective(color: PieceColor.Yellow, number: 1, pieceType: PieceType.Dit))
        //        levelObjectives.append(Objective(color: PieceColor.Green, number: 1, pieceType: PieceType.Dot))
        //        levelObjectives.append(Objective(color: PieceColor.Green, number: 3, pieceType: PieceType.Dat))
        //        levelObjectives.append(Objective(color: PieceColor.Green, number: 3, pieceType: PieceType.Dit))
        self.levelObjectives = LevelObjectives(objectives: levelObjectives)
        
        // Set current state
        self.currentState = getCurrentState()
    }
}