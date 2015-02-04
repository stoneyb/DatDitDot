import SpriteKit

class LevelEnd: SKScene {
    
    init(size: CGSize, win: Bool) {
        super.init(size: size)
        
        backgroundColor = SKColorForPieceColorEnum(PieceColor.Yellow)
        
        let winLoseLabel = SKLabelNode(fontNamed: "Odin Rounded")
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}