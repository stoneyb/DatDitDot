import SpriteKit

class Dat: BaseD {
    
    let eyes = SKNode()
    let rightEye: SKShapeNode
    let leftEye: SKShapeNode
    let eyeBlinkDelay: NSTimeInterval
    let eyeMoveDelay: NSTimeInterval
    let mouth: SKShapeNode
    
    
    init(sideLength: CGFloat, row: Int, col: Int, color: PieceColor, facialFeatures: Bool) {
       
        let t = SKTexture(imageNamed: "square")
        let background = SKSpriteNode(texture: t, size: CGSize(width: sideLength, height: sideLength))
        
        let eyeSize = sideLength / 16
        
        leftEye = SKShapeNode(circleOfRadius: eyeSize)
        rightEye = SKShapeNode(circleOfRadius: eyeSize)
        eyeBlinkDelay = NSTimeInterval(random(Range(start: 10, end: 20)))
        eyeMoveDelay = NSTimeInterval(random(Range(start: 2, end: 5)))
        mouth = SKShapeNode(rect: CGRect(x: -sideLength / 8, y: -sideLength / 4, width: sideLength / 4, height: eyeSize / 4), cornerRadius: 1)
        if facialFeatures {
            leftEye.strokeColor = CustomColors.darkGray()
            leftEye.fillColor = CustomColors.darkGray()
            leftEye.position = CGPoint(x: -sideLength / 4, y: 0)
            eyes.addChild(leftEye)
            
            rightEye.strokeColor = CustomColors.darkGray()
            rightEye.fillColor = CustomColors.darkGray()
            rightEye.position = CGPoint(x: sideLength / 4, y: 0)
            eyes.addChild(rightEye)
            
            eyes.zPosition = 1
            eyes.position = CGPoint(x: 0, y: sideLength / 6)
            
            mouth.strokeColor = CustomColors.darkGray()
            mouth.fillColor = CustomColors.darkGray()
            mouth.zPosition = 1
        }

        
        super.init(background: background, color: color, row: row, col: col)
        
        if facialFeatures {
            addChild(eyes)
            addChild(mouth)
            eyeMove()
            eyeBlink()
        }
        
        type = .Dat
        name = "Dat"
    }
    
    func eyeMove() {
        eyes.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.moveByX(2, y: 0, duration: 0.5),
                SKAction.waitForDuration(eyeMoveDelay),
                SKAction.moveByX(-2, y: 0, duration: 0.5),
                SKAction.waitForDuration(eyeMoveDelay),
                SKAction.moveByX(-2, y: 0, duration: 0.5),
                SKAction.waitForDuration(eyeMoveDelay),
                SKAction.moveByX(2, y: 0, duration: 0.5),
                SKAction.waitForDuration(eyeMoveDelay),
                ])))
    }
    
    func eyeBlink() {
        leftEye.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.waitForDuration(eyeBlinkDelay),
            SKAction.scaleXBy(1.5, y: 0.25, duration: 0.3),
            SKAction.scaleXBy(0.666, y: 4.0, duration: 0.3),
            ])))
        rightEye.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.waitForDuration(eyeBlinkDelay),
            SKAction.scaleXBy(1.5, y: 0.25, duration: 0.3),
            SKAction.scaleXBy(0.666, y: 4.0, duration: 0.3),
            ])))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func getNeighbors() -> [Position] {
        var positions = [Position]()
        positions.append(Position(row: self.row, col: self.col + 1))
        positions.append(Position(row: self.row, col: self.col - 1))
        positions.append(Position(row: self.row + 1, col: self.col))
        positions.append(Position(row: self.row - 1, col: self.col))
        return positions
    }
    
    class func CreateDummyDat(sideLength: CGFloat, color: PieceColor, facialFeatures: Bool) -> Dat {
        let dat = Dat(sideLength: sideLength, row: -1, col: -1, color: color, facialFeatures: facialFeatures)
        dat.background.color = SKColorForPieceColorEnum(color)
        dat.name = "DummyDat"
        return dat
    }
}