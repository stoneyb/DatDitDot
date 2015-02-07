import SpriteKit

class RestartButton: SKNode {
    
    let buttonColor = SKColorForPieceColorEnum(PieceColor.Green)
    let buttonColorPressed = SKColorForPieceColorEnum(PieceColor.Purple)
    let restartBackground: SKShapeNode
    let restartShadow: SKShapeNode
    let restart: SKSpriteNode
    
    init(buttonSize: CGSize) {
        
        let padding: CGFloat = 5
        
        restartBackground = SKShapeNode(rectOfSize: CGSize(width: buttonSize.width + padding, height: buttonSize.height + padding), cornerRadius: 5)
        restartBackground.fillColor = buttonColor
        restartBackground.strokeColor = buttonColor
        restartBackground.name = "Restart"
        restartBackground.zPosition = 5
        
        restartShadow = SKShapeNode(rectOfSize: CGSize(width: buttonSize.width + padding, height: buttonSize.height + padding), cornerRadius: 5)
        restartShadow.fillColor = SHADOW_COLOR
        restartShadow.strokeColor = SHADOW_COLOR
        restartShadow.position = SHADOW_OFFSET
        restartShadow.zPosition = 0
        
        restart = SKSpriteNode(imageNamed: "restart")
        restart.size = CGSize(width: buttonSize.width, height: buttonSize.height)
        restart.color = SKColor.whiteColor()
        restart.colorBlendFactor = 1.0
        restart.name = "Restart"
        restart.zPosition = 10
        
        super.init()
        
        addChild(restartBackground)
        addChild(restartShadow)
        addChild(restart)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tapped() {
        restartShadow.hidden = true
        restartBackground.position = SHADOW_OFFSET
        restart.position = SHADOW_OFFSET
        restartBackground.fillColor = buttonColorPressed
        restartBackground.strokeColor = buttonColorPressed
    }
    
    func untapped() {
        restartShadow.hidden = false
        restartBackground.position = CGPointZero
        restart.position = CGPointZero
        restartBackground.fillColor = buttonColor
        restartBackground.strokeColor = buttonColor
    }
}
