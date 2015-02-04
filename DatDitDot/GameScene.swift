import SpriteKit

class GameScene: SKScene {
    
    let backgroundLayer = SKNode()
    let hudTopLayer = SKNode()
    let needsBar = SKNode()
    let movesCount: SKLabelNode
    var currentMoves: Int
    let hudBottomLayer = SKNode()
    let playArea = SKNode()
    var curLevelNum = 1
    var curLevel: Level = Level.CreateLevel(1)
    var restartingLevel: Bool = false
    var objectiveLabels = [PieceTypeColor: [ObjectiveLabel]]()
    var noTouching: Bool = false
    
    // Offsets
    let topHudMargin: CGFloat
    let topHudElementWidth: CGFloat
    let topHudHeight: CGFloat
    
    
    let EXPERIMENT_MODE = true
    
    override init(size: CGSize) {
        
        backgroundLayer.zPosition = 10
        hudTopLayer.zPosition = 50
        hudBottomLayer.zPosition = 50
        playArea.zPosition = 50
        
        topHudMargin = 5.0
        topHudElementWidth = (size.width - (topHudMargin * 4)) / 5
        topHudHeight = 100.0
        
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
            loadLevel(Level10())
        }
    }
    
    func setupBackground() {
        backgroundColor = SKColor.whiteColor()
        
        addChild(backgroundLayer)
    }
    
    func setupTopHud() {
        let sideBackgroundHeight: CGFloat = 140
        let mainBackgroundHeight: CGFloat = 210
        let bannerBackgroundHeight: CGFloat = 70
        let backgroundCornerRadius: CGFloat = 15
        
        // Needs label background
        let labelBackgroundWidth = topHudElementWidth * 2
        let needsLabelBackground = SKShapeNode(rectOfSize: CGSize(width: labelBackgroundWidth, height: bannerBackgroundHeight), cornerRadius: backgroundCornerRadius)
        needsLabelBackground.strokeColor = SKColorForPieceColorEnum(PieceColor.Blue)
        needsLabelBackground.fillColor = SKColorForPieceColorEnum(PieceColor.Blue)
        needsLabelBackground.position = CGPoint(x: size.width / 2, y: size.height)
        needsLabelBackground.zPosition = 5
        needsBar.addChild(needsLabelBackground)
        
        // Needs label
        let needsLabel = SKLabelNode(fontNamed: "Odin Bold")
        needsLabel.fontColor = SKColor.whiteColor()
        needsLabel.fontSize = 18
        needsLabel.horizontalAlignmentMode = .Center
        needsLabel.verticalAlignmentMode = .Center
        needsLabel.text = "OBJECTIVES"
        needsLabel.position = CGPoint(x: size.width / 2, y: size.height - bannerBackgroundHeight / 4)
        needsLabel.zPosition = 10
        needsBar.addChild(needsLabel)
        
        // Needs bar
        let needsBarBackground = SKShapeNode(rectOfSize: CGSize(width: topHudElementWidth * 3 - 20, height: mainBackgroundHeight), cornerRadius: backgroundCornerRadius)
        needsBarBackground.strokeColor = CustomColors.lightBlue()
        needsBarBackground.fillColor = CustomColors.lightBlue()
        needsBarBackground.position = CGPoint(x: size.width / 2, y: size.height)
        needsBarBackground.zPosition = 0
        needsBar.addChild(needsBarBackground)
        
        // Needs bar shadow
        let needsBarShadow = SKShapeNode(rectOfSize: CGSize(width: topHudElementWidth * 3 - 20, height: mainBackgroundHeight), cornerRadius: backgroundCornerRadius)
        needsBarShadow.strokeColor = CustomColors.darkGray()
        needsBarShadow.fillColor = CustomColors.darkGray()
        needsBarShadow.position = CGPoint(x: size.width / 2 + 5, y: size.height - 4)
        needsBarShadow.zPosition = -1
        needsBar.addChild(needsBarShadow)
        
        hudTopLayer.addChild(needsBar)
        
        // Moves background
        let movesBackgroundWidth = topHudElementWidth // skip margin
        let movesBackground = SKShapeNode(rectOfSize: CGSize(width: movesBackgroundWidth, height: sideBackgroundHeight), cornerRadius: backgroundCornerRadius)
        movesBackground.strokeColor = CustomColors.lightBlue()
        movesBackground.fillColor = CustomColors.lightBlue()
        movesBackground.position = CGPoint(x: movesBackgroundWidth / 2 + topHudMargin, y: size.height)
        movesBackground.zPosition = 0
        needsBar.addChild(movesBackground)
        
        // Moves shadow
        let movesShadowWidth = topHudElementWidth // skip margin
        let movesShadow = SKShapeNode(rectOfSize: CGSize(width: movesBackgroundWidth, height: sideBackgroundHeight), cornerRadius: backgroundCornerRadius)
        movesShadow.strokeColor = CustomColors.darkGray()
        movesShadow.fillColor = CustomColors.darkGray()
        movesShadow.position = CGPoint(x: movesBackgroundWidth / 2 + topHudMargin + 5, y: size.height - 4)
        movesShadow.zPosition = -1
        needsBar.addChild(movesShadow)
        
        // Moves Label background
        let movesLabelBackgroundWidth = topHudElementWidth - 10 // skip margin
        let movesLabelBackground = SKShapeNode(rectOfSize: CGSize(width: movesLabelBackgroundWidth, height: bannerBackgroundHeight), cornerRadius: backgroundCornerRadius)
        movesLabelBackground.strokeColor = SKColorForPieceColorEnum(PieceColor.Blue)
        movesLabelBackground.fillColor = SKColorForPieceColorEnum(PieceColor.Blue)
        movesLabelBackground.position = CGPoint(x: movesBackgroundWidth / 2 + topHudMargin, y: size.height)
        movesLabelBackground.zPosition = 5
        needsBar.addChild(movesLabelBackground)

        // Moves label
        let movesLabel = SKLabelNode(fontNamed: "Odin Bold")
        movesLabel.fontColor = SKColor.whiteColor()
        movesLabel.fontSize = 18
        movesLabel.horizontalAlignmentMode = .Center
        movesLabel.verticalAlignmentMode = .Center
        movesLabel.text = "MOVES"
        movesLabel.position = CGPoint(x: movesBackgroundWidth / 2 + topHudMargin, y: size.height - bannerBackgroundHeight / 4)
        movesLabel.zPosition = 10
        needsBar.addChild(movesLabel)
        
        // Moves count
        movesCount.fontColor = CustomColors.darkGray()
        movesCount.fontSize = 24
        movesCount.horizontalAlignmentMode = .Center
        movesCount.verticalAlignmentMode = .Center
        movesCount.text = "47"
        movesCount.position = CGPoint(x: movesBackgroundWidth / 2 + topHudMargin, y: size.height - 3 * bannerBackgroundHeight / 4)
        movesCount.zPosition = 10
        needsBar.addChild(movesCount)
        
        // Menu background
        let menuBackgroundWidth = topHudElementWidth // skip margin
        let menuBackground = SKShapeNode(rectOfSize: CGSize(width: movesBackgroundWidth, height: sideBackgroundHeight), cornerRadius: backgroundCornerRadius)
        menuBackground.strokeColor = CustomColors.lightBlue()
        menuBackground.fillColor = CustomColors.lightBlue()
        menuBackground.position = CGPoint(x: size.width - menuBackgroundWidth / 2 - topHudMargin - 5, y: size.height)
        menuBackground.zPosition = 0
        needsBar.addChild(menuBackground)
        
        // Menu shadow
        let menuShadow = SKShapeNode(rectOfSize: CGSize(width: movesBackgroundWidth, height: sideBackgroundHeight), cornerRadius: backgroundCornerRadius)
        menuShadow.strokeColor = CustomColors.darkGray()
        menuShadow.fillColor = CustomColors.darkGray()
        menuShadow.position = CGPoint(x: size.width - menuBackgroundWidth / 2 - topHudMargin + 5 - 5, y: size.height - 4)
        menuShadow.zPosition = -1
        needsBar.addChild(menuShadow)
        
        // Menu
        let menu = SKNode()
        let menuColor = SKColor.whiteColor()
        menu.name = "Menu"
        menu.zPosition = 1
        for i in 0..<4 {
            let line = SKShapeNode(rectOfSize: CGSize(width: 35, height: 6), cornerRadius: 1)
            line.fillColor = menuColor
            line.strokeColor = menuColor
            line.position = CGPoint(x: 0, y: 10 * CGFloat(i))
            menu.addChild(line)
        }
        menu.position = CGPoint(x: size.width - menuBackgroundWidth / 2 - topHudMargin - 5, y: size.height - 45)
        menu.zPosition = 5
        hudTopLayer.addChild(menu)
                
        addChild(hudTopLayer)
    }
    
    func setupBottomHud() {
        let hudBottomHeight: CGFloat = 80
        let iAdSize: CGFloat = 50
        let hudBottomBackgroundColor = SKColor.whiteColor()
        let hudBottomBackgroundSize = CGSize(width: size.width, height: hudBottomHeight) // iAd size
        let hudBottomBackground = SKSpriteNode(color: hudBottomBackgroundColor, size: hudBottomBackgroundSize)
        hudBottomBackground.position = CGPoint(x: 0, y: iAdSize) // iAd size
        hudBottomBackground.anchorPoint = CGPointZero
        hudBottomLayer.addChild(hudBottomBackground)
        
        let restartBackground = SKShapeNode(rectOfSize: CGSize(width: 48, height: 48), cornerRadius: 5)
        restartBackground.fillColor = CustomColors.lightBlue()
        restartBackground.strokeColor = CustomColors.lightBlue()
        restartBackground.position = CGPoint(x: size.width / 2, y: iAdSize + hudBottomHeight / 2)
        restartBackground.zPosition = 5
        hudBottomLayer.addChild(restartBackground)
        
        let restartShadow = SKShapeNode(rectOfSize: CGSize(width: 48, height: 48), cornerRadius: 5)
        restartShadow.fillColor = CustomColors.darkGray()
        restartShadow.strokeColor = CustomColors.darkGray()
        restartShadow.position = CGPoint(x: size.width / 2 + 5, y: iAdSize + hudBottomHeight / 2 - 4)
        restartShadow.zPosition = 0
        hudBottomLayer.addChild(restartShadow)
        
        let restart = SKSpriteNode(imageNamed: "refresh")
        restart.size = CGSize(width: 48, height: 48)
        restart.color = SKColor.whiteColor()
        restart.colorBlendFactor = 1.0
        restart.position = CGPoint(x: size.width / 2, y: iAdSize + hudBottomHeight / 2)
        restart.name = "Restart"
        restart.zPosition = 10
        hudBottomLayer.addChild(restart)
        
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
        var halfPieces: CGFloat = CGFloat(objectives.count) / 2
        var halfMargins: CGFloat = (CGFloat(objectives.count) - 1) / 2
        var offset = 0
        let staticOff: CGFloat = 50
        let pieceMargin: CGFloat = 10
        let widthOffset = topHudElementWidth + topHudMargin + pieceMargin + 10
        for objective in objectives {
            if objective.number > 3 {
                halfPieces++
                halfMargins++
            }
        }
        for (i, objective) in enumerate(objectives) {
            if objective.number > 3 { // split into two rows
                for k in 0..<3 {
                    let objectiveLabel = ObjectiveLabel(type: objective.type, color: objective.color, number: objective.number)
                    let pieceWidth: CGFloat = objectiveLabel.width
                    let posX = widthOffset + pieceWidth * halfPieces - pieceMargin * halfMargins
                    let posY = size.height - staticOff - (20 * CGFloat(k))
                    objectiveLabel.position = CGPoint(x: posX + (pieceWidth + pieceMargin) * CGFloat(i + offset),
                        y: posY)
                    objectiveLabel.zPosition = 1
                    hudTopLayer.addChild(objectiveLabel)
                    objectiveLabels[PieceTypeColor(type: objectiveLabel.type, color: objectiveLabel.color)]!.append(objectiveLabel)
                }
                offset++
                for l in 0..<(objective.number - 3) {
                    let objectiveLabel = ObjectiveLabel(type: objective.type, color: objective.color, number: objective.number)
                    let pieceWidth: CGFloat = objectiveLabel.width
                    let posX = widthOffset + pieceWidth * halfPieces - pieceMargin * halfMargins
                    let posY = size.height - staticOff - (20 * CGFloat(l))
                    objectiveLabel.position = CGPoint(x: posX + (pieceWidth + pieceMargin) * CGFloat(i + offset),
                        y: posY)
                    objectiveLabel.zPosition = 1
                    hudTopLayer.addChild(objectiveLabel)
                    objectiveLabels[PieceTypeColor(type: objectiveLabel.type, color: objectiveLabel.color)]!.append(objectiveLabel)
                }
            }
            else {
                for j in 0..<objective.number {
                    let objectiveLabel = ObjectiveLabel(type: objective.type, color: objective.color, number: objective.number)
                    let pieceWidth: CGFloat = objectiveLabel.width
                    let posX = widthOffset + pieceWidth * halfPieces - pieceMargin * halfMargins
                    let posY = size.height - staticOff - (20 * CGFloat(j))
                    objectiveLabel.position = CGPoint(x: posX + (pieceWidth + pieceMargin) * CGFloat(i + offset),
                        y: posY)
                    objectiveLabel.zPosition = 1
                    hudTopLayer.addChild(objectiveLabel)
                    objectiveLabels[PieceTypeColor(type: objectiveLabel.type, color: objectiveLabel.color)]!.append(objectiveLabel)
                }
            }
        }
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
                self.loadLevel(Level.CreateLevel(++self.curLevelNum))
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
        let piecesWide = level.piecesWide
        let pieceWidth: CGFloat = level.halfSideLength
        let pieceMargin: CGFloat = 15.0
        let boardWidth: CGFloat = CGFloat(piecesWide) * pieceWidth + (pieceMargin * (CGFloat(piecesWide) - 1)) + 15
        let boardHeight: CGFloat = boardWidth
        let halfPieces: CGFloat = CGFloat(piecesWide) / 2
        let halfMargins: CGFloat = (CGFloat(piecesWide) - 1) / 2
        let startPosX: CGFloat = size.width / 2 - pieceWidth * halfPieces - pieceMargin * halfMargins + pieceWidth / 2
        let startPosY: CGFloat = size.height / 2 - pieceWidth * halfPieces - pieceMargin * halfMargins + pieceWidth / 2
        for row in 0..<piecesWide {
            for col in 0..<piecesWide {
                level.board[row][col].position = CGPoint(x: startPosX + (pieceWidth + pieceMargin) * CGFloat(col),
                                                         y: startPosY + (pieceWidth + pieceMargin) * CGFloat(row))
                playArea.addChild(level.board[row][col])
            }
        }
        
        let boardBackground = SKShapeNode(rectOfSize: CGSize(width: boardWidth, height: boardWidth), cornerRadius: 5)
        boardBackground.fillColor = CustomColors.lightBlue()
        boardBackground.strokeColor = CustomColors.lightBlue()
        boardBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
        boardBackground.zPosition = -1
        playArea.addChild(boardBackground)
        
        let levelBackground = SKShapeNode(rectOfSize: CGSize(width: boardWidth / 2, height: 60), cornerRadius: 5)
        levelBackground.fillColor = CustomColors.lightBlue()
        levelBackground.strokeColor = CustomColors.lightBlue()
        levelBackground.position = CGPoint(x: size.width / 2, y: size.height / 2 + boardWidth / 2)
        levelBackground.zPosition = -1
        playArea.addChild(levelBackground)
        
        let levelShadow = SKShapeNode(rectOfSize: CGSize(width: boardWidth / 2, height: 60), cornerRadius: 5)
        levelShadow.fillColor = CustomColors.darkGray()
        levelShadow.strokeColor = CustomColors.darkGray()
        levelShadow.position = CGPoint(x: size.width / 2 + 5, y: size.height / 2 + boardWidth / 2 - 4)
        levelShadow.zPosition = -2
        playArea.addChild(levelShadow)
        
        let levelLabel = SKLabelNode(fontNamed: "Odin Bold")
        levelLabel.fontColor = SKColor.whiteColor()
        levelLabel.fontSize = 20
        levelLabel.horizontalAlignmentMode = .Center
        levelLabel.verticalAlignmentMode = .Center
        levelLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 + boardWidth / 2 + 15)
        levelLabel.text = "LEVEL " + String(level.number)
        levelLabel.zPosition = 0
        playArea.addChild(levelLabel)
        
        let boardShadow = SKShapeNode(rectOfSize: CGSize(width: boardWidth, height: boardWidth), cornerRadius: 5)
        boardShadow.fillColor = CustomColors.darkGray()
        boardShadow.strokeColor = CustomColors.darkGray()
        boardShadow.position = CGPoint(x: size.width / 2 + 5, y: size.height / 2 - 4)
        boardShadow.zPosition = -2
        playArea.addChild(boardShadow)
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
                        println("Add strikethrough")
                        label.addStrikeThrough()
                        objDiff++
                    }
                }
            } else if objDiff > 0 {
                for label in labels.reverse() {
                    if label.completed == true && objDiff > 0 {
                        println("Add strikethrough")
                        label.removeStrikeThrough()
                        objDiff--
                    }
                }
            } else {
                // No change
            }
        }
    }
    
    func checkWinLoseConditions() {
        if EXPERIMENT_MODE {
            return
        }
        updateObjectives()
        if curLevel.checkWin() {
            println("You win")
            messageBox("You win!")
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
            piece.tapped()
            for position in piece.getNeighbors() {
                if position.row >= 0 && position.row < curLevel.piecesWide &&
                    position.col >= 0 && position.col < curLevel.piecesHigh {
                        if curLevel.board[position.row][position.col].changeColor(piece.color) {
                            changed = true
                        }
                }
            }
            if changed {
                curLevel.currentState = curLevel.getCurrentState()
                moved()
            }
            checkWinLoseConditions()
        }
    }
    
    func handleRestartTouch(touch: UITouch) {
        let loc = touch.locationInNode(hudBottomLayer)
        var node: SKNode? = hudBottomLayer.nodeAtPoint(loc)
        if node?.name == "Restart" && !restartingLevel{
            restartingLevel = true
            restartLevel()
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
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        
        // Can always hit menu
        handleMenuTouch(touch)
        
        if noTouching {
            return
        }
        handlePieceTouch(touch)
        handleRestartTouch(touch)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
