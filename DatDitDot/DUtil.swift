import SpriteKit

enum PieceType: Int {
    case Unknown = 0
    case Dat = 1
    case Dit = 2
    case Dot = 3
    
    static let allValues = [Unknown, Dat, Dit, Dot]
}

func stringForPieceType(pieceType: PieceType) -> String {
    switch (pieceType) {
        case .Unknown:
            return "Unknown"
        case .Dat:
            return "Dat"
        case .Dit:
            return "Dit"
        case .Dot:
            return "Dot"
    }
}

func createBaseDForType(pieceType: PieceType, sideLength: CGFloat, color: PieceColor, facialFeatures: Bool) -> BaseD {
    switch pieceType {
        case .Dat:
            return Dat.CreateDummyDat(sideLength, color: color, facialFeatures: facialFeatures)
        case .Dit:
            return Dit.CreateDummyDit(sideLength, color: color, facialFeatures: facialFeatures)
        case .Dot:
            return Dot.CreateDummyDot(sideLength, color: color, facialFeatures: facialFeatures)
        case .Unknown:
            return Dot.CreateDummyDot(sideLength, color: color, facialFeatures: facialFeatures)
    }
}