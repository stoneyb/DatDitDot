import SpriteKit

class Level10: Level {
    
    override init() {
        super.init()
        
        // Setup level
        self.number = 10
        
        // Setup board
        piecesHigh = 4
        piecesWide = 4
        halfSideLength = 20.0
        let facial = true
        let row0 = [Dit(sideLength: halfSideLength, row: 0, col: 0, color: PieceColor.Green, facialFeatures: facial),
            Dot(sideLength: halfSideLength, row: 0, col: 1, color: PieceColor.Green, facialFeatures: facial),
            Dat(sideLength: halfSideLength, row: 0, col: 2, color: PieceColor.Green, facialFeatures: facial),
            Dat(sideLength: halfSideLength, row: 0, col: 3, color: PieceColor.Green, facialFeatures: facial)]
        let row1 = [Dit(sideLength: halfSideLength, row: 1, col: 0, color: PieceColor.Green, facialFeatures: facial),
            Dot(sideLength: halfSideLength, row: 1, col: 1, color: PieceColor.Red, facialFeatures: facial),
            Dat(sideLength: halfSideLength, row: 1, col: 2, color: PieceColor.Green, facialFeatures: facial),
            Dat(sideLength: halfSideLength, row: 1, col: 3, color: PieceColor.Green, facialFeatures: facial)]
        let row2 = [Dit(sideLength: halfSideLength, row: 2, col: 0, color: PieceColor.Green, facialFeatures: facial),
            Dot(sideLength: halfSideLength, row: 2, col: 1, color: PieceColor.Green, facialFeatures: facial),
            Dot(sideLength: halfSideLength, row: 2, col: 2, color: PieceColor.Green, facialFeatures: facial),
            Dat(sideLength: halfSideLength, row: 2, col: 3, color: PieceColor.Blue, facialFeatures: facial)]
        let row3 = [Dit(sideLength: halfSideLength, row: 3, col: 0, color: PieceColor.Green, facialFeatures: facial),
            Dot(sideLength: halfSideLength, row: 3, col: 1, color: PieceColor.Green, facialFeatures: facial),
            Dat(sideLength: halfSideLength, row: 3, col: 2, color: PieceColor.Green, facialFeatures: facial),
            Dat(sideLength: halfSideLength, row: 3, col: 3, color: PieceColor.Green, facialFeatures: facial)]
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
        
        // Set moves
        moves = 10
        
        // Set current state
        self.currentState = getCurrentState()
    }
}