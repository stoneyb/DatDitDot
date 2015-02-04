import SpriteKit

// CONSTANTS
let BANNER_HEADER_COLOR = SKColorForPieceColorEnum(PieceColor.Blue)
let BANNER_COLOR = CustomColors.lightBlue()
let SHADOW_COLOR = CustomColors.darkGray()

enum PieceColor: Int {
    case Red = 0
    case Yellow = 1
    case Green = 2
    case Blue = 3
    case Purple = 4
    
    static let allValues = [Red, Yellow, Green, Blue, Purple]
}

func randomPieceColor() -> PieceColor {
    return PieceColor(rawValue: Int(arc4random()) % 5)!
}

func SKColorForPieceColorEnum(color: PieceColor) -> SKColor {
    switch(color) {
    case .Red:
        return SKColor(red: 1, green: 0.431, blue: 0.42, alpha: 1)
    case .Blue:
        return SKColor(red: 0.345, green: 0.816, blue: 0.949, alpha: 1)
    case .Green:
        return SKColor(red: 0.357, green: 0.855, blue: 0.392, alpha: 1)
    case .Yellow:
        return SKColor(red: 1, green: 0.91, blue: 0.42, alpha: 1)
    case .Purple:
        return SKColor(red: 0.678, green: 0.506, blue: 0.769, alpha: 1)
    }
}


func stringForPieceColor(pieceColor: PieceColor) -> String {
    switch(pieceColor) {
        case .Red:
            return "Red"
        case .Yellow:
            return "Yellow"
        case .Green:
            return "Green"
        case .Blue:
            return "Blue"
        case .Purple:
            return "Purple"
    }
}

let darkGray = SKColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
let lightBlue  = SKColor(red: 0.6, green: 0.851, blue: 0.961, alpha: 1)

class CustomColors {
    
    private struct STATIC {
        static let darkGray = SKColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
        static let lightGray = SKColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        static let lightBlue = SKColor(red: 0.6, green: 0.851, blue: 0.961, alpha: 1)
    }
    
    class func darkGray() -> SKColor {
        return STATIC.darkGray
    }
    
    class func lightGray() -> SKColor {
        return STATIC.lightGray
    }
    
    class func lightBlue() -> SKColor {
        return STATIC.lightBlue
    }
}

extension SKShapeNode {
    var color: SKColor {
        get {
            return self.fillColor
        }
        
        set {
            self.fillColor = newValue
        }
    }
}