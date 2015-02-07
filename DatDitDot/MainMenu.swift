import SpriteKit

class MainMenu: SKScene {
    let title: SKNode
    let letterD1: SKLabelNode
    let letterD2: SKLabelNode
    let letterD3: SKLabelNode
    let letterT1: SKLabelNode
    let letterT2: SKLabelNode
    let letterT3: SKLabelNode
    var curColor = 0
    
    override init(size: CGSize) {
        title = SKNode()
        let fontName = "Quicksand"
        letterD1 = SKLabelNode(fontNamed: fontName)
        letterD2 = SKLabelNode(fontNamed: fontName)
        letterD3 = SKLabelNode(fontNamed: fontName)
        letterT1 = SKLabelNode(fontNamed: fontName)
        letterT2 = SKLabelNode(fontNamed: fontName)
        letterT3 = SKLabelNode(fontNamed: fontName)
        super.init(size: size)
        
        backgroundColor = SKColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        setupPlayButton()
        //setupLevelSelectButton()
        //setupTitle()
        //title.position = CGPoint(x: size.width / 2, y: size.height - size.height / 6)
        //title.runAction(SKAction.scaleBy(1.75, duration: 0))
        //addChild(title)
        setupTitle2()
        setupScoresButton()
        setupAchievementsButton()
        //startActions()
    }
    
    func setupPlayButton() {
        let heightOffset: CGFloat = 250
        
        let play = SKLabelNode(fontNamed: "Quicksand")
        play.name = "PlayButton"
        play.text = "play"
        play.fontColor = CustomColors.darkGray()
        play.fontSize = 32
        play.horizontalAlignmentMode = .Center
        let offsett: CGFloat = 25
        let degrees: CGFloat = 65
        play.position = CGPoint(x: size.width / 2 - 40, y: size.height - heightOffset)
        play.runAction(SKAction.rotateByAngle(degrees.degreesToRadians(), duration: 0))
        //addChild(play)
        
        
        let sideLength: CGFloat = 75
        let radius:CGFloat = sideLength / 5;
        let path = CGPathCreateMutable();
        let center = CGPoint(x: sideLength, y: sideLength * 2)
        let bottomLeft = CGPoint(x: 0, y: 0)
        let bottomRight = CGPoint(x: sideLength * 2, y: 0)
        CGPathMoveToPoint(path, nil, (center.x + bottomLeft.x) / 2, (center.y + bottomLeft.y) / 2);
        CGPathAddArcToPoint(path, nil, bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y, radius);
        CGPathAddArcToPoint(path, nil, bottomRight.x, bottomRight.y, center.x, center.y, radius);
        CGPathAddArcToPoint(path, nil, center.x, center.y, bottomLeft.x, bottomLeft.y, radius);
        CGPathCloseSubpath(path);
        
        let playTriangle = SKShapeNode(path: path, centered: true)
        playTriangle.name = "PlayButton"
        playTriangle.fillColor = SKColor.clearColor()
        playTriangle.strokeColor = CustomColors.darkGray()
        playTriangle.position = CGPoint(x: size.width / 2, y: size.height - heightOffset)
        addChild(playTriangle)

        let moveEffect = SKTMoveEffect(node: play,
                                       duration: 2,
                                       startPosition: play.position,
                                       endPosition: CGPoint(x: size.width / 2, y: size.height / 2 + 15))

        moveEffect.timingFunction = SKTTimingFunctionBackEaseOut
        
        //play.runAction(SKAction.sequence([
        //        SKAction.actionWithEffect(moveEffect),
        //    ]))
    }
    
    func setupScoresButton() {
        let heightOffset: CGFloat = 375
        let scores = SKNode()
        scores.name = "Scores"
        
        let color = CustomColors.darkGray()
        let fontName = "Quicksand"
        let fontSize: CGFloat = 25
        let width: CGFloat = 45
        
        let barMid = SKShapeNode(rectOfSize: CGSize(width: width, height: 100))
        barMid.fillColor = SKColor.clearColor()
        barMid.strokeColor = color
        barMid.position = CGPoint(x: 0, y: 0)
        
        let labelRight = SKLabelNode(fontNamed: fontName)
        labelRight.horizontalAlignmentMode = .Left
        //labelRight.verticalAlignmentMode = .Center
        labelRight.position = CGPoint(x: width / 2 + 2, y: -50)
        labelRight.text = "eaderboard"
        labelRight.fontColor = color
        labelRight.fontSize = fontSize
        scores.addChild(labelRight)
        
        scores.addChild(barMid)
        scores.position = CGPoint(x: size.width / 2, y: size.height - heightOffset)
        
        addChild(scores)
    }
    
    func setupLevelSelectButton() {
        let levelText = SKLabelNode(fontNamed: "Quicksand")
        levelText.name = "LevelSelect"
        levelText.text = "level"
        levelText.fontColor = CustomColors.darkGray()
        levelText.fontSize = 32
        levelText.horizontalAlignmentMode = .Center
        levelText.position = CGPoint(x: 2 * size.width / 3, y: 2 * size.height / 5 + 52)
        addChild(levelText)
        
        let selectText = SKLabelNode(fontNamed: "Quicksand")
        selectText.name = "LevelSelect"
        selectText.text = "select"
        selectText.fontColor = CustomColors.darkGray()
        selectText.fontSize = 32
        selectText.horizontalAlignmentMode = .Center
        selectText.position = CGPoint(x: 2 * size.width / 3 + 52, y: 2 * size.height / 5)
        let degrees: CGFloat = 270
        selectText.runAction(SKAction.rotateByAngle(degrees.degreesToRadians(), duration: 0))
        addChild(selectText)
        
        let shapeSize: CGFloat = 25
        
        let selectRect = SKShapeNode(rectOfSize: CGSize(width: 100, height: 100))
        selectRect.name = "LevelSelect"
        selectRect.fillColor = SKColor.clearColor() //CustomColors.darkGray()
        selectRect.strokeColor = CustomColors.darkGray()
        selectRect.position = CGPoint(x: 2 * size.width / 3, y: 2 * size.height / 5)
        addChild(selectRect)
        
        let moveEffect = SKTMoveEffect(node: levelText, duration: 2, startPosition: levelText.position, endPosition: CGPoint(x: size.width / 2, y: size.height / 2 - 15))
        
        moveEffect.timingFunction = SKTTimingFunctionBackEaseOut
        
        //levelSelect.runAction(SKAction.sequence([
        //    SKAction.actionWithEffect(moveEffect),
        //    ]))
    }
    
    func setupAchievementsButton() {
        let heightOffset: CGFloat = 500
        let achievements = SKNode()
        
        let achCircle = SKShapeNode(circleOfRadius: 45)
        achCircle.name = "AchievementButton"
        achCircle.fillColor = SKColor.clearColor()
        achCircle.strokeColor = CustomColors.darkGray()
        achCircle.position = CGPoint(x: size.width / 2, y: size.height - heightOffset)
        addChild(achCircle)
        
        let achLabel = SKLabelNode(fontNamed: "Quicksand")
        achLabel.fontColor = CustomColors.darkGray()
        achLabel.fontSize = 30
        achLabel.horizontalAlignmentMode = .Left
        achLabel.verticalAlignmentMode = .Center
        achLabel.text = "ptions"
        achLabel.position = CGPoint(x: size.width / 2 + 47, y: size.height - heightOffset)
        addChild(achLabel)
        
        addChild(achievements)
    }

    func getNextColor() -> SKColor {
        let color = SKColorForPieceColorEnum(PieceColor(rawValue: curColor)!)
        curColor++
        if curColor % (PieceColor.allValues.count - 1) == 0 {
            curColor = 0
        }
        return color
    }
    
    func rotateBackgroundColor() {
        let origColors = CGColorGetComponents(self.backgroundColor.CGColor)
        let origRed: CGFloat = origColors[0]
        let origGreen: CGFloat = origColors[1]
        let origBlue: CGFloat = origColors[2]
        
        let newColors = CGColorGetComponents(getNextColor().CGColor)
        let newRed: CGFloat = newColors[0]
        let newGreen: CGFloat = newColors[1]
        let newBlue: CGFloat = newColors[2]
        
        let duration:NSTimeInterval = 0.75
        runAction(SKAction.customActionWithDuration(duration, actionBlock: {
            node, elapsedTime in
            let percentage = elapsedTime / CGFloat(duration)
            let red = origRed - ((origRed - newRed) * percentage)
            let green = origGreen - ((origGreen - newGreen) * percentage)
            let blue = origBlue - ((origBlue - newBlue) * percentage)
            self.backgroundColor = SKColor(red: red, green: green, blue: blue, alpha: 1)
        }))
    }
    
    func setupTitle() {
        let dOffset: CGFloat = -26
        let tOffset: CGFloat = 20
        let shapeSize: CGFloat = 12
        let color = CustomColors.darkGray()
        let fontSize: CGFloat = 38
        
        // DAT
        letterD1.text = "d"
        letterD1.fontColor = color
        letterD1.fontSize = fontSize
        letterD1.horizontalAlignmentMode = .Center
        letterD1.verticalAlignmentMode = .Center
        letterD1.position = CGPoint(x: dOffset, y: 0)
        letterD1.alpha = 0
        title.addChild(letterD1)
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 0, 0)
        CGPathAddLineToPoint(path, nil, shapeSize, shapeSize * 2)
        CGPathAddLineToPoint(path, nil, shapeSize * 2, 0)
        CGPathAddLineToPoint(path, nil, 0, 0)
        
        let letterA = SKShapeNode(path: path, centered: true)
        letterA.fillColor = color
        letterA.strokeColor = color
        title.addChild(letterA)
        
        letterT1.text = "t"
        letterT1.fontColor = color
        letterT1.fontSize = fontSize
        letterT1.horizontalAlignmentMode = .Center
        letterT1.verticalAlignmentMode = .Center
        letterT1.position = CGPoint(x: tOffset, y: 0)
        letterT1.alpha = 0
        title.addChild(letterT1)
        
        let offsetY1: CGFloat = -30.0
        let offsetY2: CGFloat = -60.0
        
        // DIT
        letterD2.text = "d"
        letterD2.fontColor = color
        letterD2.fontSize = fontSize
        letterD2.horizontalAlignmentMode = .Center
        letterD2.verticalAlignmentMode = .Center
        letterD2.position = CGPoint(x: dOffset, y: offsetY1)
        letterD2.alpha = 0
        title.addChild(letterD2)
        
        let letterI = SKShapeNode(rectOfSize: CGSize(width: 12, height: 24))
        letterI.fillColor = color
        letterI.strokeColor = color
        letterI.position = CGPoint(x: 0, y: offsetY1)
        title.addChild(letterI)
        
        letterT2.text = "t"
        letterT2.fontColor = color
        letterT2.fontSize = fontSize
        letterT2.horizontalAlignmentMode = .Center
        letterT2.verticalAlignmentMode = .Center
        letterT2.position = CGPoint(x: tOffset, y: offsetY1)
        letterT2.alpha = 0
        title.addChild(letterT2)
        
        // DOT
        letterD3.text = "d"
        letterD3.fontColor = color
        letterD3.fontSize = fontSize
        letterD3.horizontalAlignmentMode = .Center
        letterD3.verticalAlignmentMode = .Center
        letterD3.position = CGPoint(x: dOffset, y: offsetY2)
        letterD3.alpha = 0
        title.addChild(letterD3)
        
        let letterO = SKShapeNode(circleOfRadius: 12)
        letterO.fillColor = color
        letterO.strokeColor = color
        letterO.position = CGPoint(x: 0, y: offsetY2)
        title.addChild(letterO)
        
        letterT3.text = "t"
        letterT3.fontColor = color
        letterT3.fontSize = fontSize
        letterT3.horizontalAlignmentMode = .Center
        letterT3.verticalAlignmentMode = .Center
        letterT3.position = CGPoint(x: tOffset, y: offsetY2)
        letterT3.alpha = 0
        title.addChild(letterT3)
        
    }
    
    func setupTitle2() {
        let title = SKLabelNode(fontNamed: "Quicksand")
        title.text = "dat dit dot"
        title.fontColor = CustomColors.darkGray()
        title.fontSize = 50
        title.horizontalAlignmentMode = .Center
        title.verticalAlignmentMode = .Center
        title.position = CGPoint(x: size.width / 2, y: size.height - 100)
        addChild(title)
        
        let line = SKShapeNode(rectOfSize: CGSize(width: 300, height: 1))
        line.strokeColor = CustomColors.darkGray()
        line.fillColor = CustomColors.darkGray()
        line.position = CGPoint(x: size.width / 2, y: size.height - 130)
        addChild(line)
    }
    
    func startActions() {
        let delay: NSTimeInterval = 3
        let fadeDelay: NSTimeInterval = 0.75
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.waitForDuration(delay),
                SKAction.runBlock({
                    self.rotateBackgroundColor()
                })
                ])))
        
        letterD1.runAction(SKAction.sequence([
            SKAction.waitForDuration(delay),
            SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.fadeInWithDuration(fadeDelay),
                    SKAction.waitForDuration(delay - fadeDelay),
                    SKAction.fadeOutWithDuration(fadeDelay),
                    SKAction.waitForDuration(delay*2 - fadeDelay)
                ]))
            ]))
        letterT1.runAction(SKAction.sequence([
            SKAction.waitForDuration(delay),
            SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.fadeInWithDuration(fadeDelay),
                    SKAction.waitForDuration(delay - fadeDelay),
                    SKAction.fadeOutWithDuration(fadeDelay),
                    SKAction.waitForDuration(delay*2 - fadeDelay)
                    ]))
            ]))
        letterD2.runAction(SKAction.sequence([
            SKAction.waitForDuration(delay*2),
            SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.fadeInWithDuration(fadeDelay),
                    SKAction.waitForDuration(delay - fadeDelay),
                    SKAction.fadeOutWithDuration(fadeDelay),
                    SKAction.waitForDuration(delay*2 - fadeDelay)
                    ]))
            ]))
        letterT2.runAction(SKAction.sequence([
            SKAction.waitForDuration(delay*2),
            SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.fadeInWithDuration(fadeDelay),
                    SKAction.waitForDuration(delay - fadeDelay),
                    SKAction.fadeOutWithDuration(fadeDelay),
                    SKAction.waitForDuration(delay*2 - fadeDelay)
                    ]))
            ]))
        letterD3.runAction(SKAction.sequence([
            SKAction.waitForDuration(delay*3),
            SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.fadeInWithDuration(fadeDelay),
                    SKAction.waitForDuration(delay - fadeDelay),
                    SKAction.fadeOutWithDuration(fadeDelay),
                    SKAction.waitForDuration(delay*2 - fadeDelay)
                    ]))
            ]))
        letterT3.runAction(SKAction.sequence([
            SKAction.waitForDuration(delay*3),
            SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.fadeInWithDuration(fadeDelay),
                    SKAction.waitForDuration(delay - fadeDelay),
                    SKAction.fadeOutWithDuration(fadeDelay),
                    SKAction.waitForDuration(delay*2 - fadeDelay)
                    ]))
            ]))
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let loc = touch.locationInNode(self)
        var node: SKNode? = nodeAtPoint(loc)
        if node?.name == "PlayButton" {
            //view?.presentScene(GameScene(size: view!.bounds.size))
            view?.presentScene(GameScene(size: view!.bounds.size, level: Level.CreateLevel(1)), transition: SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 1.0))
        }
    }
    
}