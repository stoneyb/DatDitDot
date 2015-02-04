import SpriteKit

class Objective {
    let color: PieceColor
    let number: Int
    let type: PieceType
    
    init(color: PieceColor, number: Int, pieceType: PieceType) {
        self.color = color
        self.number = number
        self.type = pieceType
    }

    var description: String {
        return String(format: "%d of %s %s", self.number,
                                             stringForPieceColor(self.color),
                                             stringForPieceType(self.type))
    }
}