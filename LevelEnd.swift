import SpriteKit

class LevelEnd: SKScene {
    
    init(size: CGSize, win: Bool) {
        super.init(size: size)
        
        backgroundColor = SKColorForPieceColorEnum(PieceColor.Yellow)
        
        let winLoseLabel = SKLabelNode(fontNamed: PRIMARY_FONT_NAME)
        winLoseLabel.horizontalAlignmentMode = .Center
        winLoseLabel.verticalAlignmentMode = .Center
        winLoseLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        winLoseLabel.fontSize = 40
        winLoseLabel.fontColor = CustomColors.darkGray()
        if win {
            winLoseLabel.text = "GOOD JOB"
        } else {
            winLoseLabel.text = "BAD JOB"
        }
        addChild(winLoseLabel)
        
    }
    
    override func didMoveToView(view: SKView) {
        
        let moveEffect = SKTMoveEffect(node: self, duration: 1, startPosition: position, endPosition: position - CGPoint(x: -100, y: 0))
        moveEffect.timingFunction = SKTTimingFunctionBackEaseIn
        runAction(SKAction.actionWithEffect(moveEffect))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}