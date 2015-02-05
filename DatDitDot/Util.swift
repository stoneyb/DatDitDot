import Foundation
import SpriteKit

// CONSTANTS
let SHADOW_OFFSET = CGPoint(x: 5, y: -4)
let PRIMARY_FONT_NAME = "Odin Rounded"

enum GameState: Int {
    case Running = 0
    case Paused = 1
    case Restarting = 2
    
}

class PieceTypeColor: Hashable, Printable {
    struct Static {
        static let RedDot = PieceTypeColor(type: PieceType.Dot, color: PieceColor.Red)
    }
    
    let color: PieceColor
    let type: PieceType
    
    init(type: PieceType, color: PieceColor) {
        self.color = color
        self.type = type
    }
    
    var hashValue: Int {
        return (13 * (self.color.hashValue + 1)) ^ (15 * (self.type.hashValue + 1))
    }
    
    var description: String {
        get {
            return NSString(format: "PTC(%@ %@)", stringForPieceColor(self.color), stringForPieceType(self.type))
        }
    }
}

func ==(lhs: PieceTypeColor, rhs: PieceTypeColor) -> Bool {
    return lhs.color == rhs.color && lhs.type == rhs.type
}

func random(range: Range<UInt32>) -> UInt32 {
    return range.startIndex + arc4random_uniform(range.endIndex - range.startIndex + 1)
}