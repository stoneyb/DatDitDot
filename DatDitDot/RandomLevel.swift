import SpriteKit

class RandomLevel: Level {
    
    override init() {
        super.init()
        
        self.number = 1337
        
        // Setup board
        piecesHigh = Int(random(Range(start: 3, end: 5)))
        piecesWide = Int(random(Range(start: 3, end: 5)))
        for row in 0..<piecesHigh {
            var bRow = [BaseD]()
            for col in 0..<piecesWide {
                bRow.append(randomDitDatDot(sideLength, row: row, col: col))
            }
            board.append(bRow)
        }
        
        // Setup objectives
        var levelObjectives = [Objective]()
        levelObjectives.append(Objective(color: PieceColor.Red, number: 3, pieceType: PieceType.Dot))
        //levelObjectives.append(Objective(color: PieceColor.Red, number: 3, pieceType: PieceType.Dat))
        //levelObjectives.append(Objective(color: PieceColor.Red, number: 3, pieceType: PieceType.Dit))
        self.levelObjectives = LevelObjectives(objectives: levelObjectives)
        
        // Set moves
        moves = 50
        
        // Set current state
        self.currentState = getCurrentState()
    }
    
    func randomDitDatDot(pieceWidth: CGFloat, row: Int, col: Int) -> BaseD {
        let randInt = arc4random() % 3
        switch(randInt) {
        case 0:
            return Dit(sideLength: pieceWidth, row: row, col: col, color: randomPieceColor(), facialFeatures: true)
        case 1:
            return Dat(sideLength: pieceWidth, row: row, col: col, color: randomPieceColor(), facialFeatures: true)
        case 2:
            return Dot(sideLength: pieceWidth, row: row, col: col, color: randomPieceColor(), facialFeatures: true)
        default:
            return Dot(sideLength: pieceWidth, row: row, col: col, color: randomPieceColor(), facialFeatures: true)
        }
    }
}