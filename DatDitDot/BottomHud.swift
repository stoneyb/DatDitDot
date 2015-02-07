import SpriteKit

class BottomHud : SKNode {
    
    let restartButton: RestartButton
    let leaderboardButton: LeaderboardButton
    let buttonHeight: CGFloat
    let buttonMargin: CGFloat
    
    init(hudHeight: CGFloat) {
        buttonHeight = hudHeight / 2
        buttonMargin = 7.5
        restartButton = RestartButton(buttonSize: CGSize(width: buttonHeight, height: buttonHeight))
        leaderboardButton = LeaderboardButton(buttonSize: CGSize(width: buttonHeight, height: buttonHeight))
        
        super.init()
        
        buildHud()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHud() {
        
        leaderboardButton.position = CGPoint(x: -buttonHeight / 2 - buttonMargin, y: 0)
        restartButton.position = CGPoint(x: buttonHeight / 2 + buttonMargin, y: 0)
        
        addChild(restartButton)
        addChild(leaderboardButton)
    }  
    
}