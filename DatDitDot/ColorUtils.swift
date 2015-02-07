import SpriteKit

// CONSTANTS
let BANNER_HEADER_COLOR = CustomColors.darkTeal()
let BANNER_COLOR = CustomColors.teal()
let BOARD_COLOR = CustomColors.lightBlue()
let SHADOW_COLOR = CustomColors.lightGray()


enum PieceColor: Int {
    case Red = 0
    case Yellow = 1
    case Green = 2
    case Blue = 3
    case Purple = 4
    case Orange = 5
    
    static let allValues = [Red, Yellow, Green, Blue, Purple, Orange]
}

func randomPieceColor() -> PieceColor {
    return PieceColor(rawValue: Int(arc4random()) % 6)!
}

func SKColorForPieceColorEnum(color: PieceColor) -> SKColor {
    switch(color) {
    case .Red:
        return SKColor(red: 1, green: 0.431, blue: 0.42, alpha: 1)
    case .Blue:
        //return SKColor(red: 0.345, green: 0.816, blue: 0.949, alpha: 1)
        return SKColor(red: 0.4, green: 0.788, blue: 0.973, alpha: 1)
    case .Green:
        return SKColor(red: 0, green: 0.756, blue: 0.286, alpha: 1)
    case .Yellow:
        return SKColor(red: 1, green: 0.91, blue: 0.42, alpha: 1)
    case .Purple:
        return SKColor(red: 0.678, green: 0.506, blue: 0.769, alpha: 1)
    case .Orange:
        return SKColor(red: 1, green: 0.537, blue: 0.098, alpha: 1)
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
        case .Orange:
            return "Orange"
    }
}

class CustomColors {
    
    private struct STATIC {
        static let darkGray = SKColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
        static let lightGray = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        static let lightBlue = SKColor(red: 0.588, green: 0.902, blue: 0.961, alpha: 1)
        static let brightBlue = SKColor(red: 0.118, green: 0.306, blue: 1, alpha: 1)
        static let gold = SKColor(red: 1, green: 0.737, blue: 0, alpha: 1)
        static let silver = SKColor(red: 0.753, green: 0.753, blue: 0.753, alpha: 1)
        static let bronze = SKColor(red: 0.804, green: 0.498, blue: 0.196, alpha: 1)
        static let teal = SKColor(red: 0.682, green: 0.937, blue: 0.875, alpha: 1)
        static let lightYellow = SKColor(red: 0.827, green: 0.741, blue: 0.447, alpha: 1)
        static let lightRed = SKColor(red: 1, green: 0.439, blue: 0.455, alpha: 1)
        static let darkTeal = SKColor(red: 0.612, green: 0.897, blue: 0.835, alpha: 1)

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
    
    class func brightBlue() -> SKColor {
        return STATIC.brightBlue
    }
    
    class func gold() -> SKColor {
        return STATIC.gold
    }
    
    class func silver() -> SKColor {
        return STATIC.silver
    }
    
    class func bronze() -> SKColor {
        return STATIC.bronze
    }
    
    class func teal() -> SKColor {
        return STATIC.teal
    }
    
    class func darkTeal() -> SKColor {
        return STATIC.darkTeal
    }
    
    class func lightYellow() -> SKColor {
        return STATIC.lightYellow
    }
    
    class func lightRed() -> SKColor {
        return STATIC.lightRed
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