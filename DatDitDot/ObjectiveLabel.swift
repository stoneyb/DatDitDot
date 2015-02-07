import SpriteKit

class ObjectiveLabel: SKNode {
    let baseD: BaseD
    let number: Int
    let color: PieceColor
    let type: PieceType
    let sideLength: CGFloat
    var completed: Bool = false
    let strikeThrough: SKShapeNode
    
    init(sideLength: CGFloat, type: PieceType, color: PieceColor, number: Int) {
        self.number = number
        self.type = type
        self.color = color
        self.sideLength = sideLength
        self.baseD = createBaseDForType(type, sideLength, color, false)
        strikeThrough = SKShapeNode(rectOfSize: CGSize(width: 3, height: 19))
        strikeThrough.fillColor = CustomColors.darkGray()
        strikeThrough.strokeColor = CustomColors.darkGray()
        strikeThrough.runAction(SKAction.rotateByAngle(π/4, duration: 0))
        strikeThrough.name = "Strikethrough"
        strikeThrough.hidden = true
        strikeThrough.zPosition = 1
        
        super.init()

        self.baseD.position = CGPoint(x: 0, y: 0) //center

        addChild(self.baseD)
        addChild(strikeThrough)
        
        name = "ObjectiveLabel"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeStrikeThrough() {
        completed = false
        let moveEffect = SKTMoveEffect(node: strikeThrough, duration: 0.75, startPosition: strikeThrough.position, endPosition: CGPoint(x: -10, y: 10))
        moveEffect.timingFunction = SKTTimingFunctionBackEaseIn //SKTTimingFunctionBounceEaseOut
        
        strikeThrough.runAction(SKAction.group([
            SKAction.actionWithEffect(moveEffect),
            SKAction.fadeInWithDuration(0.75)
            ]), completion: {
                self.strikeThrough.hidden = true
        })
    }
    
    func addStrikeThrough() {
        completed = true
        strikeThrough.hidden = false
        strikeThrough.position = CGPoint(x: -10.0, y: 10.0)
        strikeThrough.alpha = 1
        
        let moveEffect = SKTMoveEffect(node: strikeThrough, duration: 0.75, startPosition: strikeThrough.position, endPosition: CGPoint(x: 0, y: 0))
        moveEffect.timingFunction = SKTTimingFunctionBackEaseOut //SKTTimingFunctionBounceEaseOut
        
        strikeThrough.runAction(SKAction.group([
            SKAction.actionWithEffect(moveEffect),
            SKAction.fadeInWithDuration(0.75)
            ]))
    }
}