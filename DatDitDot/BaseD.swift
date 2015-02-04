import SpriteKit

class BaseD: SKNode {
    let background: SKShapeNode!
    var color: PieceColor
    let col: Int
    let row: Int
    var type: PieceType
    
    init(background: SKShapeNode, color: PieceColor, row: Int, col: Int){
        self.background = background
        self.color = color
        background.fillColor = SKColorForPieceColorEnum(color)
        background.strokeColor = SKColorForPieceColorEnum(color)
        self.col = col
        self.row = row
        self.type = .Unknown

        super.init()

        addChild(background)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeColor(color: PieceColor) -> Bool {
        if color == self.color {
            return false
        }
        self.color = color
        
        let origColors = CGColorGetComponents(self.background.fillColor.CGColor)
        let origRed: CGFloat = origColors[0]
        let origGreen: CGFloat = origColors[1]
        let origBlue: CGFloat = origColors[2]
        
        let newColors = CGColorGetComponents(SKColorForPieceColorEnum(color).CGColor)
        let newRed: CGFloat = newColors[0]
        let newGreen: CGFloat = newColors[1]
        let newBlue: CGFloat = newColors[2]
        
        let duration:NSTimeInterval = 0.75
        background.runAction(SKAction.customActionWithDuration(duration, actionBlock: {
            node, elapsedTime in
            
            let node = node as SKShapeNode
            let percentage = elapsedTime / CGFloat(duration)
            let red = origRed - ((origRed - newRed) * percentage)
            let green = origGreen - ((origGreen - newGreen) * percentage)
            let blue = origBlue - ((origBlue - newBlue) * percentage)
            node.fillColor = SKColor(red: red, green: green, blue: blue, alpha: 1)
            node.strokeColor = SKColor(red: red, green: green, blue: blue, alpha: 1)
        }))
        
        return true
    }
    
    func getNeighbors() -> [Position] {
        fatalError("This method must be overridden")
    }
    
    func tapped() {
        let newNode = createBaseDForType(self.type, self.background.frame.width / 2, self.color, false)
        newNode.background.lineWidth = 0.0
        newNode.background.removeFromParent()
        addChild(newNode.background)
        newNode.background.runAction(SKAction.sequence([
                SKAction.group([
                    SKAction.scaleTo(2.0, duration: 0.5),
                    SKAction.fadeOutWithDuration(0.5)
                    ]),
                SKAction.removeFromParent()
            ]))
    }
    
}
