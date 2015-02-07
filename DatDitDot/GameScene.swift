import SpriteKit

class GameScene: SKScene {
    
    let backgroundLayer = SKNode()
    let hudTopLayer = SKNode()
    let bottomHud: BottomHud
    let needsBar = SKNode()
    let movesCount: SKLabelNode
    var currentMoves: Int
    let hudBottomLayer = SKNode()
    let playArea = SKNode()
    var curLevel: Level
    var restartingLevel: Bool = false
    var objectiveLabels = [PieceTypeColor: [ObjectiveLabel]]()
    var noTouching: Bool = false
    
    // Offsets
    let topHudMargin: CGFloat
    let topHudElementWidth: CGFloat
    let topHudHeight: CGFloat
    
    // CONSTANTS
    let BOT_HUD_HEIGHT: CGFloat = 100
    
    let EXPERIMENT_MODE = false
    
    init(size: CGSize, level: Level) {
        self.curLevel = level
        backgroundLayer.zPosition = 10
        hudTopLayer.zPosition = 50
        hudBottomLayer.zPosition = 50
        playArea.zPosition = 50
        
        topHudMargin = 5.0
        topHudElementWidth = (size.width - (topHudMargin * 4)) / 5
        topHudHeight = 100.0

        bottomHud = BottomHud(hudHeight: BOT_HUD_HEIGHT)
        
        movesCount = SKLabelNode(fontNamed: "Odin Bold")
        currentMoves = 0
        
        super.init(size: size)
        
        initializeObjectiveLabels()
        setupBackground()
        setupTopHud()
        setupBottomHud()
        setupPlayArea()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        // Initial load
        if EXPERIMENT_MODE {
            loadLevel(RandomLevel())
        } else {
            loadLevel(self.curLevel)
        }
    }
    
    func setupBackground() {
        backgroundColor = SKColor.whiteColor()
        
        let line = SKShapeNode(rectOfSize: CGSize(width: 1, height: size.height))
        line.zPosition = 1000
        line.fillColor = CustomColors.darkGray()
        line.strokeColor = CustomColors.darkGray()
        line.position = CGPoint(x: size.width / 2, y: size.height / 2)
        //addChild(line)
        
        addChild(backgroundLayer)
    }
    
    func setupTopHud() {
        let sideBackgroundHeight: CGFloat = 140
        let mainBackgroundHeight: CGFloat = 225
        let bannerBackgroundHeight: CGFloat = 70
        let backgroundCornerRadius: CGFloat = 15
        let largeBannerTexture = SKTexture(imageNamed: "round_rect_200x200")
        let mediumBannerTextureTall = SKTexture(imageNamed: "round_rect_100x200")
        let mediumBannerTextureWide = SKTexture(imageNamed: "round_rect_200x100")
        
        // Needs label banner background
        let labelBackgroundWidth = topHudElementWidth * 2
        let needsLabelBackground = SKSpriteNode(texture: mediumBannerTextureWide, size: CGSize(width: labelBackgroundWidth, height: bannerBackgroundHeight))
        needsLabelBackground.colorBlendFactor = 1
        needsLabelBackground.color = BANNER_HEADER_COLOR
        needsLabelBackground.position = CGPoint(x: size.width / 2, y: size.height)
        needsLabelBackground.zPosition = 5
        needsBar.addChild(needsLabelBackground)
        
        // Needs label
        let needsLabel = SKLabelNode(fontNamed: PRIMARY_FONT_NAME)
        needsLabel.fontColor = SKColor.whiteColor()
        needsLabel.fontSize = 18
        needsLabel.horizontalAlignmentMode = .Center
        needsLabel.verticalAlignmentMode = .Center
        needsLabel.text = "OBJECTIVES"
        needsLabel.position = CGPoint(x: size.width / 2, y: size.height - bannerBackgroundHeight / 4)
        needsLabel.zPosition = 10
        needsBar.addChild(needsLabel)
        
        // Needs background
        let needsBarBackground = SKSpriteNode(texture: largeBannerTexture, size: CGSize(width: topHudElementWidth * 3, height: mainBackgroundHeight))
        needsBarBackground.colorBlendFactor = 1
        needsBarBackground.color = BANNER_COLOR
        needsBarBackground.position = CGPoint(x: size.width / 2, y: size.height)
        needsBarBackground.zPosition = 0
        needsBar.addChild(needsBarBackground)
        
        // Needs background shadow
        let needsBarShadow = SKSpriteNode(texture: largeBannerTexture, size: CGSize(width: topHudElementWidth * 3, height: mainBackgroundHeight))
        needsBarShadow.colorBlendFactor = 1
        needsBarShadow.color = SHADOW_COLOR
        needsBarShadow.position = needsBarBackground.position + SHADOW_OFFSET
        needsBarShadow.zPosition = -1
        needsBar.addChild(needsBarShadow)
        
        hudTopLayer.addChild(needsBar)
        
        // Moves
        let moves = SKNode()
        
        // Moves count
        movesCount.fontColor = CustomColors.darkGray()
        movesCount.fontSize = 32
        movesCount.horizontalAlignmentMode = .Center
        movesCount.verticalAlignmentMode = .Center
        movesCount.text = "47"
        movesCount.zPosition = 10
        movesCount.position = CGPoint(x: 25, y: 0)
        moves.addChild(movesCount)
        
        // Finger 
        let finger = SKSpriteNode(imageNamed: "one_finger")
        finger.size = CGSize(width: 27, height: 27)
        finger.colorBlendFactor = 1
        finger.color = CustomColors.darkGray()
        finger.zPosition = 10
        moves.addChild(finger)
        let movesX: CGFloat = 8
        moves.position = CGPoint(x: topHudElementWidth / 2 - movesX, y: size.height - 11 * mainBackgroundHeight / 32)
        hudTopLayer.addChild(moves)
        
        // Goals
        let starSize: CGFloat = 10.0
        let goals = Goals(level: curLevel, starSize: starSize)
        goals.position = CGPoint(x: topHudElementWidth / 2 + starSize, y: size.height - mainBackgroundHeight / 7)
        hudTopLayer.addChild(goals)

        
        // Menu
        let menuColor = SKColorForPieceColorEnum(PieceColor.Purple)
        let menuTexture = SKTexture(imageNamed: "grid_60x60")
        let menu = SKSpriteNode(texture: menuTexture, size: CGSize(width: 40, height: 40))
        menu.colorBlendFactor = 1
        menu.color = menuColor
        menu.position = CGPoint(x: size.width - topHudElementWidth / 2 - topHudMargin / 2, y: size.height - mainBackgroundHeight / 4)
        hudTopLayer.addChild(menu)
        
        addChild(hudTopLayer)
    }
    
    func setupBottomHud() {
        let iAdSize: CGFloat = 50

        bottomHud.position = CGPoint(x: size.width / 2, y: iAdSize + BOT_HUD_HEIGHT / 2)
        hudBottomLayer.addChild(bottomHud)
        
        addChild(hudBottomLayer)
    }
    
    func setupPlayArea() {
        addChild(playArea)
    }
    
    func blendBackgroundColor(toColor: SKColor) {
        let origColors = CGColorGetComponents(self.backgroundColor.CGColor)
        let origRed: CGFloat = origColors[0]
        let origGreen: CGFloat = origColors[1]
        let origBlue: CGFloat = origColors[2]
        
        let newColors = CGColorGetComponents(toColor.CGColor)
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
    
    func initializeObjectiveLabels() {
        for type in PieceType.allValues {
            for color in PieceColor.allValues {
                objectiveLabels[PieceTypeColor(type: type, color: color)] = [ObjectiveLabel]()
            }
        }
    }
    
    func clearObjectiveLabels() {
        for type in PieceType.allValues {
            for color in PieceColor.allValues {
                for objectiveLabel in objectiveLabels[PieceTypeColor(type: type, color: color)]! {
                    objectiveLabel.removeFromParent()
                }
                objectiveLabels[PieceTypeColor(type: type, color: color)]!.removeAll(keepCapacity: true)
            }
        }
    }
    
    func createObjectiveBar(objectives: [Objective]) {
        clearObjectiveLabels()
        let objectivesBar = SKNode()
        var piecesWide: CGFloat = CGFloat(objectives.count)
        var numMargins: CGFloat = CGFloat(objectives.count) - 1
        let yOffset: CGFloat = 90
        let pieceMargin: CGFloat = 10
        let pieceWidth: CGFloat = 15
        let needsBarBackground: CGFloat = topHudElementWidth * 3 - 20
        for objective in objectives {
            if objective.number > 3 {
                piecesWide++
                numMargins++
            }
        }
        var curColumn: CGFloat = 0
        let fullWidth = piecesWide * pieceWidth + numMargins * pieceMargin - pieceWidth // first one is centered
        for (i, objective) in enumerate(objectives) {
            if objective.number > 3 { // split into two columns
                for k in 0..<3 {
                    let objectiveLabel = ObjectiveLabel(sideLength: pieceWidth, type: objective.type, color: objective.color, number: objective.number)
                    let posX = (pieceWidth + pieceMargin) * curColumn
                    let posY = 40 - 20 * CGFloat(k)
                    objectiveLabel.position = CGPoint(x: posX, y: posY)
                    objectiveLabel.zPosition = 2
                    objectivesBar.addChild(objectiveLabel)
                    objectiveLabels[PieceTypeColor(type: objectiveLabel.type, color: objectiveLabel.color)]!.append(objectiveLabel)
                }
                curColumn++
                for l in 0..<(objective.number - 3) {
                    let objectiveLabel = ObjectiveLabel(sideLength: pieceWidth, type: objective.type, color: objective.color, number: objective.number)
                    let posX = (pieceWidth + pieceMargin) * curColumn
                    let posY = 40 - 20 * CGFloat(l)
                    objectiveLabel.position = CGPoint(x: posX, y: posY)
                    objectiveLabel.zPosition = 2
                    objectivesBar.addChild(objectiveLabel)
                    objectiveLabels[PieceTypeColor(type: objectiveLabel.type, color: objectiveLabel.color)]!.append(objectiveLabel)
                }
            }
            else {
                for j in 0..<objective.number {
                    let objectiveLabel = ObjectiveLabel(sideLength: pieceWidth, type: objective.type, color: objective.color, number: objective.number)
                    let posX = (pieceWidth + pieceMargin) * curColumn
                    let posY = 40 - 20 * CGFloat(j)
                    objectiveLabel.position = CGPoint(x: posX, y: posY)
                    objectiveLabel.zPosition = 2
                    objectivesBar.addChild(objectiveLabel)
                    objectiveLabels[PieceTypeColor(type: objectiveLabel.type, color: objectiveLabel.color)]!.append(objectiveLabel)
                }
            }
            curColumn++
        }
        objectivesBar.position = CGPoint(x: size.width / 2 - fullWidth / 2, y: size.height - yOffset)
        hudTopLayer.addChild(objectivesBar)
    }
    
    func restartLevel() {
        let moveOutEffect = SKTMoveEffect(node: playArea, duration: 0.75, startPosition: playArea.position, endPosition: CGPoint(x: size.width, y: playArea.position.y))
        let moveInEffect = SKTMoveEffect(node: playArea, duration: 0.75, startPosition: playArea.position, endPosition: CGPoint(x: size.width, y: 0))
        moveOutEffect.timingFunction = SKTTimingFunctionBackEaseIn
        moveInEffect.timingFunction = SKTTimingFunctionBackEaseOut
        playArea.runAction(SKAction.actionWithEffect(moveOutEffect), completion: {
            self.playArea.position = CGPoint(x: -self.size.width, y: 0)
            self.playArea.removeAllChildren()
            if self.EXPERIMENT_MODE {
                self.loadLevel(RandomLevel())
            } else {
                self.loadLevel(Level.CreateLevel(self.curLevel.number))
            }
            self.playArea.runAction(SKAction.actionWithEffect(moveInEffect), completion: {
                self.restartingLevel = false
                self.noTouching = false
            })
        })
    }
    
    func messageBox(text: String) {
        let loseBox = SKShapeNode(rectOfSize: CGSize(width: 250, height: 250))
        loseBox.fillColor = SKColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.75)
        loseBox.position = CGPoint(x: size.width / 2, y: size.height)
        loseBox.zPosition = 1000
        let msg = SKLabelNode(fontNamed: "Quicksand")
        msg.fontColor = SKColor.whiteColor()
        msg.fontSize = 28
        msg.horizontalAlignmentMode = .Center
        msg.verticalAlignmentMode = .Center
        msg.text = text
        loseBox.addChild(msg)
        addChild(loseBox)
        
        let moveEffect = SKTMoveEffect(node: loseBox, duration: 2, startPosition: loseBox.position, endPosition: CGPoint(x: size.width / 2, y: size.height / 2))
        moveEffect.timingFunction = SKTTimingFunctionBounceEaseOut
        
        loseBox.runAction(SKAction.sequence([
                SKAction.actionWithEffect(moveEffect),
                SKAction.waitForDuration(3.0),
                SKAction.runBlock({
                    println("Restarting level")
                    self.restartLevel()
                }),
                SKAction.removeFromParent()
            ]))
    }
    
    func loadLevel(level: Level) {
        curLevel = level
        movesCount.text = String(level.moves)
        currentMoves = level.moves
        createObjectiveBar(level.levelObjectives.objectives)
        updateObjectives()
        var delay = 0.25
        let piecesWide = level.piecesWide
        let piecesHigh = level.piecesHigh
        let pieceWidth: CGFloat = level.sideLength
        let pieceMargin: CGFloat = 3.0
        let levelBorder: CGFloat = 5.0
        let boardWidth: CGFloat = CGFloat(piecesWide) * pieceWidth + (pieceMargin * (CGFloat(piecesWide) - 1)) + 5.0
        let boardHeight: CGFloat = CGFloat(piecesHigh) * pieceWidth + (pieceMargin * (CGFloat(piecesHigh) - 1)) + 5.0
        let halfPiecesWide: CGFloat = CGFloat(piecesWide) / 2
        let halfMarginsWide: CGFloat = (CGFloat(piecesWide) - 1) / 2
        let halfPiecesHigh: CGFloat = CGFloat(piecesHigh) / 2
        let halfMarginsHigh: CGFloat = (CGFloat(piecesHigh) - 1) / 2
        let startPosX: CGFloat = size.width / 2 - pieceWidth * halfPiecesWide - pieceMargin * halfMarginsWide + pieceWidth / 2
        let startPosY: CGFloat = size.height / 2 - pieceWidth * halfPiecesHigh - pieceMargin * halfMarginsHigh + pieceWidth / 2
        for row in 0..<piecesHigh {
            for col in 0..<piecesWide {
                level.board[row][col].position = CGPoint(x: startPosX + (pieceWidth + pieceMargin) * CGFloat(col),
                                                         y: startPosY + (pieceWidth + pieceMargin) * CGFloat(row))
                playArea.addChild(level.board[row][col])
                level.board[row][col].runAction(SKAction.sequence([
                    SKAction.waitForDuration(1.3),
                    SKAction.waitForDuration(NSTimeInterval(CGFloat(Float(arc4random()) / Float(UINT32_MAX)))),
                    SKAction.runBlock({
                        level.board[row][col].bounce()
                    })]))
                delay += 0.1
            }
        }
        
        let boardBackground = SKShapeNode(rectOfSize: CGSize(width: boardWidth, height: boardHeight), cornerRadius: 5)
        boardBackground.fillColor = BOARD_COLOR
        boardBackground.strokeColor = BOARD_COLOR
        boardBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
        boardBackground.zPosition = -1
        playArea.addChild(boardBackground)
        
        let boardShadow = SKShapeNode(rectOfSize: CGSize(width: boardWidth, height: boardHeight), cornerRadius: 5)
        boardShadow.fillColor = SHADOW_COLOR
        boardShadow.strokeColor = SHADOW_COLOR
        boardShadow.position = boardBackground.position + SHADOW_OFFSET
        boardShadow.zPosition = -2
        playArea.addChild(boardShadow)
        
        let levelLabelParent = SKNode()
        levelLabelParent.zPosition = -2
        
        let levelBackground = SKShapeNode(rectOfSize: CGSize(width: 3 * boardWidth / 4, height: 60), cornerRadius: 5)
        levelBackground.fillColor = BOARD_COLOR
        levelBackground.strokeColor = BOARD_COLOR
        levelBackground.zPosition = -3
        levelLabelParent.addChild(levelBackground)
        
        let levelShadow = SKShapeNode(rectOfSize: CGSize(width: boardWidth / 2, height: 60), cornerRadius: 5)
        levelShadow.fillColor = SHADOW_COLOR
        levelShadow.strokeColor = SHADOW_COLOR
        levelShadow.position = levelBackground.position + SHADOW_OFFSET
        levelShadow.zPosition = -4
        levelLabelParent.addChild(levelShadow)
        
        let levelLabel = SKLabelNode(fontNamed: "Odin Bold")
        levelLabel.fontColor = SKColor.whiteColor()
        levelLabel.fontSize = 20
        levelLabel.horizontalAlignmentMode = .Center
        levelLabel.verticalAlignmentMode = .Center
        levelLabel.position = levelBackground.position + CGPoint(x: 0, y: 15)
        levelLabel.text = "LEVEL " + String(level.number)
        levelLabel.zPosition = -2
        levelLabelParent.addChild(levelLabel)
        
        levelLabelParent.position = CGPoint(x: size.width / 2, y: size.height / 2 + boardHeight / 2 - 30)
        playArea.addChild(levelLabelParent)
        let moveEffect = SKTMoveEffect(node: levelLabelParent, duration: 1, startPosition: levelLabelParent.position, endPosition: levelLabelParent.position + CGPoint(x: 0, y: 30))
        moveEffect.timingFunction = SKTTimingFunctionBackEaseOut
        levelLabelParent.runAction(SKAction.sequence([
            SKAction.waitForDuration(0.5),
            SKAction.actionWithEffect(moveEffect)
            ]))
    }
    
    func getCurrentObjectiveCount(key: PieceTypeColor) -> Int {
        var total: Int = 0
        for label in objectiveLabels[key]! {
            if label.completed {
                total++
            }
        }
        return total
    }
    
    func updateObjectives() {
        let currentState = curLevel.currentState
        for objective in curLevel.levelObjectives.objectives {
            let key = PieceTypeColor(type: objective.type, color: objective.color)
            let curObjectiveNum = currentState[key]!
            let targetObjectiveNum = curLevel.levelObjectives.objectiveDict[key]!
            let oldObjectiveNum = getCurrentObjectiveCount(key)
            let labels = objectiveLabels[key]!
            var objDiff = oldObjectiveNum - curObjectiveNum
            if objDiff < 0 {
                for label in labels {
                    if label.completed == false && objDiff < 0 {
                        label.addStrikeThrough()
                        objDiff++
                    }
                }
            } else if objDiff > 0 {
                for label in labels.reverse() {
                    if label.completed == true && objDiff > 0 {
                        label.removeStrikeThrough()
                        objDiff--
                    }
                }
            } else {
                // No change
            }
        }
    }
    
    func levelOver(win: Bool) {
        for row in 0..<self.curLevel.piecesHigh {
            for col in 0..<self.curLevel.piecesWide {
                self.curLevel.board[row][col].runAction(SKAction.repeatAction(SKAction.sequence([
                    SKAction.waitForDuration(NSTimeInterval(CGFloat(Float(arc4random()) / Float(UINT32_MAX)))),
                    SKAction.runBlock({
                        self.curLevel.board[row][col].bounce()
                        }),
                    SKAction.waitForDuration(1)
                    ]), count: 4))
            }
        }
        runAction(SKAction.waitForDuration(5), completion: {
                let transition = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 0.5)
                self.view?.presentScene(LevelEnd(size: self.view!.bounds.size, level: self.curLevel, win: win), transition: transition)
        })
        
        

    }
    
    func checkWinLoseConditions() {
        if EXPERIMENT_MODE {
            return
        }
        updateObjectives()
        if curLevel.checkWin() {
            levelOver(true)
            noTouching = true
        }
        else if currentMoves == 0 {
            println("You lose no more moves!")
            messageBox("Out of moves!")
            noTouching = true
        } else if curLevel.hasNoMoves() {
            println("You lose no possible moves!")
            messageBox("Can't move!")
            noTouching = true
        }
    }

    func moved() {
        currentMoves--
        movesCount.text = String(currentMoves)
        let scaleUp = SKTScaleEffect(node: movesCount, duration: 0.2, startScale: movesCount.scaleAsPoint, endScale: CGPoint(x: 1.25, y: 1.25))
        let scaleDown = SKTScaleEffect(node: movesCount, duration: 0.2, startScale: movesCount.scaleAsPoint, endScale: CGPoint(x: 0.8, y: 0.8))
        if movesCount.actionForKey("movesScale") == nil {
            movesCount.runAction(SKAction.sequence([
                SKAction.actionWithEffect(scaleUp),
                SKAction.actionWithEffect(scaleDown)
                ]), withKey: "moveScale")
        }

    }
    
    func handlePieceTouch(touch: UITouch) {
        let loc = touch.locationInNode(playArea)
        var node: SKNode? = playArea.nodeAtPoint(loc)
        if let piece = node?.parent? as? BaseD {
            var changed = false
            for position in piece.getNeighbors() {
                if position.row >= 0 && position.row < curLevel.piecesHigh &&
                    position.col >= 0 && position.col < curLevel.piecesWide {
                        if curLevel.board[position.row][position.col].changeColor(piece.color) {
                            changed = true
                        }
                }
            }
            if changed {
                piece.tapped()
                curLevel.currentState = curLevel.getCurrentState()
                moved()
            } else {
                piece.shake()
            }
            checkWinLoseConditions()
        }
    }
    
    func handleRestartTouchUp(touch: UITouch) {
        let loc = touch.locationInNode(hudBottomLayer)
        var node: SKNode? = hudBottomLayer.nodeAtPoint(loc)
        if node?.name == "Restart" && !restartingLevel{
            restartingLevel = true
            restartLevel()
            bottomHud.restartButton.untapped()
        }
    }
    
    func handleRestartTouch(touch: UITouch) {
        let loc = touch.locationInNode(hudBottomLayer)
        var node: SKNode? = hudBottomLayer.nodeAtPoint(loc)
        if node?.name == "Restart" {
            bottomHud.restartButton.tapped()
        } else {
            bottomHud.restartButton.untapped()
        }
    }
    
    func handleLeaderboardTouchUp(touch: UITouch) {
        let loc = touch.locationInNode(hudBottomLayer)
        var node: SKNode? = hudBottomLayer.nodeAtPoint(loc)
        if node?.name == "Leaderboard" {
            println("Tapped leaderboard")
            bottomHud.leaderboardButton.untapped()
        }
    }
    
    func handleLeaderboardTouch(touch: UITouch) {
        let loc = touch.locationInNode(hudBottomLayer)
        var node: SKNode? = hudBottomLayer.nodeAtPoint(loc)
        if node?.name == "Leaderboard" {
            bottomHud.leaderboardButton.tapped()
        } else {
            bottomHud.leaderboardButton.untapped()
        }
    }
    
    func handleMenuTouch(touch: UITouch) {
        let loc = touch.locationInNode(hudBottomLayer)
        var node: SKNode? = hudTopLayer.nodeAtPoint(loc)
        if node?.name == "Menu" {
            println("Tapped Menu")
            view?.presentScene(MainMenu(size: view!.bounds.size))
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        if noTouching {
            return
        }
        handleRestartTouch(touch)
        handleLeaderboardTouch(touch)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        if noTouching {
            return
        }
        handleRestartTouch(touch)
        handleLeaderboardTouch(touch)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        
        // Can always hit menu
        handleMenuTouch(touch)
        if noTouching {
            return
        }
        handlePieceTouch(touch)
        handleRestartTouchUp(touch)
        handleLeaderboardTouchUp(touch)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
