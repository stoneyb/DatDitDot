import SpriteKit

class Goals : SKNode {
    
    let level: Level
    let row1StarColor = CustomColors.gold() // bronze
    let row2StarColor = CustomColors.gold() // silver
    let row3StarColor = CustomColors.gold() // gold
    let fontColor = CustomColors.darkGray()
    
    init(level: Level, starSize: CGFloat) {
        self.level = level
        
        super.init()
        
        buildNodes(starSize)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildNodes(starSize: CGFloat) {
        let starTexture = SKTexture(imageNamed: "star")
        
        let xOffset: CGFloat = 2
        let yOffset: CGFloat = starSize / 2 + 10
        
        let row1 = SKNode()
        let star1 = SKSpriteNode(texture: starTexture, size: CGSize(width: starSize, height: starSize))
        star1.colorBlendFactor = 1
        star1.color = row1StarColor
        star1.anchorPoint = CGPoint(x: 0, y: 0.5)
        star1.position = CGPoint(x: -starSize - xOffset, y: 0)
        
        let row1Label = SKLabelNode(fontNamed: PRIMARY_FONT_NAME)
        row1Label.horizontalAlignmentMode = .Left
        row1Label.verticalAlignmentMode = .Center
        row1Label.fontColor = CustomColors.darkGray()
        row1Label.fontSize = starSize
        row1Label.text = " " + String(self.level.goals[0])
        row1Label.position = CGPoint(x: xOffset, y: -2)
        
        row1.position = CGPoint(x: 0, y: -yOffset)
        row1.addChild(star1)
        row1.addChild(row1Label)
        
        let row2 = SKNode()
        let star2 = SKSpriteNode(texture: starTexture, size: CGSize(width: starSize, height: starSize))
        star2.colorBlendFactor = 1
        star2.color = row2StarColor
        star2.anchorPoint = CGPoint(x: 0, y: 0.5)
        star2.position = CGPoint(x: -starSize - xOffset, y: 0)
        
        let star3 = SKSpriteNode(texture: starTexture, size: CGSize(width: starSize, height: starSize))
        star3.colorBlendFactor = 1
        star3.color = row2StarColor
        star3.anchorPoint = CGPoint(x: 0, y: 0.5)
        star3.position = CGPoint(x: -starSize * 2 - xOffset * 2, y: 0)
        
        let row2Label = SKLabelNode(fontNamed: PRIMARY_FONT_NAME)
        row2Label.horizontalAlignmentMode = .Left
        row2Label.verticalAlignmentMode = .Center
        row2Label.fontColor = CustomColors.darkGray()
        row2Label.fontSize = starSize
        row2Label.text = " " + String(self.level.goals[1])
        row2Label.position = CGPoint(x: xOffset, y: -2)
        
        row2.addChild(star2)
        row2.addChild(star3)
        row2.addChild(row2Label)
        
        let row3 = SKNode()
        let star4 = SKSpriteNode(texture: starTexture, size: CGSize(width: starSize, height: starSize))
        star4.colorBlendFactor = 1
        star4.color = row3StarColor
        star4.anchorPoint = CGPoint(x: 0, y: 0.5)
        star4.position = CGPoint(x: -starSize - xOffset, y: 0)
        
        let star5 = SKSpriteNode(texture: starTexture, size: CGSize(width: starSize, height: starSize))
        star5.colorBlendFactor = 1
        star5.color = row3StarColor
        star5.anchorPoint = CGPoint(x: 0, y: 0.5)
        star5.position = CGPoint(x: -starSize * 2 - xOffset * 2, y: 0)
        
        let star6 = SKSpriteNode(texture: starTexture, size: CGSize(width: starSize, height: starSize))
        star6.colorBlendFactor = 1
        star6.color = row3StarColor
        star6.anchorPoint = CGPoint(x: 0, y: 0.5)
        star6.position = CGPoint(x: -starSize * 3 - xOffset * 3, y: 0)
        
        let row3Label = SKLabelNode(fontNamed: PRIMARY_FONT_NAME)
        row3Label.horizontalAlignmentMode = .Left
        row3Label.verticalAlignmentMode = .Center
        row3Label.fontColor = CustomColors.darkGray()
        row3Label.fontSize = starSize
        row3Label.text = " " + String(self.level.goals[2])
        row3Label.position = CGPoint(x: xOffset, y: -2)
        
        row3.addChild(star4)
        row3.addChild(star5)
        row3.addChild(star6)
        row3.addChild(row3Label)
        row3.position = CGPoint(x: 0, y: yOffset)
        
        addChild(row1)
        addChild(row2)
        addChild(row3)
        
        position = CGPoint(x: 10, y: 0)
    }
    
    
    
}