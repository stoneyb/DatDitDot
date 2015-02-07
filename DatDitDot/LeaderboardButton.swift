import SpriteKit

class LeaderboardButton: SKNode {
    
    let buttonColor = SKColorForPieceColorEnum(PieceColor.Blue)
    let buttonColorPressed = SKColorForPieceColorEnum(PieceColor.Orange)
    let leaderboardBackground: SKShapeNode
    let leaderboardShadow: SKShapeNode
    let leaderboard: SKSpriteNode
    
    init(buttonSize: CGSize) {
        
        let padding: CGFloat = 5
        
        leaderboardBackground = SKShapeNode(rectOfSize: CGSize(width: buttonSize.width + padding, height: buttonSize.height + padding), cornerRadius: 5)
        leaderboardBackground.fillColor = buttonColor
        leaderboardBackground.strokeColor = buttonColor
        leaderboardBackground.name = "Leaderboard"
        leaderboardBackground.zPosition = 5
        
        leaderboardShadow = SKShapeNode(rectOfSize: CGSize(width: buttonSize.width + padding, height: buttonSize.height + padding), cornerRadius: 5)
        leaderboardShadow.fillColor = SHADOW_COLOR
        leaderboardShadow.strokeColor = SHADOW_COLOR
        leaderboardShadow.position = SHADOW_OFFSET
        leaderboardShadow.zPosition = 0
        
        leaderboard = SKSpriteNode(imageNamed: "leaderboard")
        leaderboard.size = CGSize(width: buttonSize.width, height: buttonSize.height)
        leaderboard.color = SKColor.whiteColor()
        leaderboard.colorBlendFactor = 1.0
        leaderboard.name = "Leaderboard"
        leaderboard.zPosition = 10
        
        super.init()
        
        addChild(leaderboardBackground)
        addChild(leaderboardShadow)
        addChild(leaderboard)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapped() {
        leaderboardShadow.hidden = true
        leaderboardBackground.position = SHADOW_OFFSET
        leaderboard.position = SHADOW_OFFSET
        leaderboardBackground.fillColor = buttonColorPressed
        leaderboardBackground.strokeColor = buttonColorPressed
    }
    
    func untapped() {
        leaderboardShadow.hidden = false
        leaderboardBackground.position = CGPointZero
        leaderboard.position = CGPointZero
        leaderboardBackground.fillColor = buttonColor
        leaderboardBackground.strokeColor = buttonColor
    }
}