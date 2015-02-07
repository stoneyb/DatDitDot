import SpriteKit

class BaseD: SKNode {
    let background: SKSpriteNode!
    var color: PieceColor
    let col: Int
    let row: Int
    var type: PieceType
    let mouth: SKSpriteNode
    let mouthColor: SKColor
    
    init(background: SKSpriteNode, color: PieceColor, row: Int, col: Int){
        self.background = background
        self.background.colorBlendFactor = 1.0
        self.color = color
        background.color = SKColorForPieceColorEnum(color)
        self.col = col
        self.row = row
        self.type = .Unknown
        
        let mouthTexture = SKTexture(imageNamed: "mouth")
        mouth = SKSpriteNode(texture: mouthTexture, size: CGSize(width: 10, height: 5))
        mouthColor = SKColor.whiteColor()
        
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
        
        let origColors = CGColorGetComponents(self.background.color.CGColor)
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
            
            let node = node as SKSpriteNode
            let percentage = elapsedTime / CGFloat(duration)
            let red = origRed - ((origRed - newRed) * percentage)
            let green = origGreen - ((origGreen - newGreen) * percentage)
            let blue = origBlue - ((origBlue - newBlue) * percentage)
            node.color = SKColor(red: red, green: green, blue: blue, alpha: 1)
        }))
        
        return true
    }
    
    func getNeighbors() -> [Position] {
        fatalError("This method must be overridden")
    }
    
    func shake() {
        let shakeAction = SKAction.sequence([
            SKAction.moveByX(2, y: 0, duration: 0.05),
            SKAction.moveByX(-4, y: 0, duration: 0.025),
            SKAction.moveByX(2, y: 0, duration: 0.05),
            ])
        runAction(SKAction.repeatAction(shakeAction, count: 2))
    }
    
    func bounce() {
        let moveEffectUp = SKTMoveEffect(node: self, duration: 0.1, startPosition: position, endPosition: position + CGPoint(x: 0, y: 10))
        let moveEffectDown = SKTMoveEffect(node: self, duration: 0.4, startPosition: position, endPosition: position + CGPoint(x: 0, y: -10))
        moveEffectDown.timingFunction = SKTTimingFunctionBounceEaseOut
        mouth.texture = SKTexture(imageNamed: "circle_eye")
        mouth.size = CGSize(width: 5, height: 5)
        runAction(SKAction.sequence([
            SKAction.actionWithEffect(moveEffectUp),
            SKAction.actionWithEffect(moveEffectDown),
            SKAction.waitForDuration(0.5),
            SKAction.runBlock({
                moveEffectUp.startPosition = moveEffectUp.previousPosition
                moveEffectDown.startPosition = moveEffectDown.previousPosition
                self.mouth.texture = SKTexture(imageNamed: "mouth")
                self.mouth.size = CGSize(width: 10, height: 5)
            })
            ]))
    }
    
    func tapped() {
        bounce()
        let newNode = createBaseDForType(self.type, self.background.frame.width, self.color, false)
        newNode.background.removeFromParent()
        newNode.zPosition = 100
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
