import SpriteKit

class Dit: BaseD {
    
    let eye: SKSpriteNode
    let eyeBlinkDelay: NSTimeInterval
    let eyeMoveDelay: NSTimeInterval
    
    init(sideLength: CGFloat, row: Int, col: Int, color: PieceColor, facialFeatures: Bool) {
        let triangleTexture = SKTexture(imageNamed: "triangle")
        let circleTexture = SKTexture(imageNamed: "circle_eye")
        let background = SKSpriteNode(texture: triangleTexture, size: CGSize(width: sideLength, height: sideLength))
        
        eye = SKSpriteNode(texture: circleTexture, size: CGSize(width: 7, height: 7))
        eyeBlinkDelay = NSTimeInterval(random(Range(start: 10, end: 20)))
        eyeMoveDelay = NSTimeInterval(random(Range(start: 2, end: 5)))

        super.init(background: background, color: color, row: row, col: col)
        
        if facialFeatures {
            eye.colorBlendFactor = 1
            eye.color = CustomColors.darkGray()
            eye.position = CGPoint(x: 0, y: 0)
            eye.zPosition = 1
            
            mouth.colorBlendFactor = 1
            mouth.color = mouthColor
            mouth.position = CGPoint(x: 0, y: -10)
            mouth.zPosition = 1
            
            addChild(eye)
            addChild(mouth)
            eyeMove()
            eyeBlink()
        }

        type = .Dit
        name = "Dit"
    }
    
    func eyeMove() {
        eye.runAction(SKAction.repeatActionForever(
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
        eye.runAction(SKAction.repeatActionForever(SKAction.sequence([
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
        positions.append(Position(row: self.row + 1, col: self.col))
        positions.append(Position(row: self.row - 1, col: self.col - 1))
        positions.append(Position(row: self.row - 1, col: self.col + 1))
        return positions
    }
    
    class func CreateDummyDit(sideLength: CGFloat, color: PieceColor, facialFeatures: Bool) -> Dit {
        let dit = Dit(sideLength: sideLength, row: -1, col: -1, color: color, facialFeatures: facialFeatures)
        dit.background.color = SKColorForPieceColorEnum(color)
        dit.name = "DummyDit"
        return dit
    }
}