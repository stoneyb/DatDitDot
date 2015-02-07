import SpriteKit

class LevelEnd: SKScene {
    
    let levelEnded: Level
    
    init(size: CGSize, level: Level, win: Bool) {
        self.levelEnded = level
        
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
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let transition = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 0.5)
        view?.presentScene(GameScene(size: view!.bounds.size, level: Level.CreateLevel(++self.levelEnded.number)), transition: transition)
    }

}