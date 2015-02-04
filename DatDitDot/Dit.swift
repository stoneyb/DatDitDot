import SpriteKit

class Dit: BaseD {
    
    let eye: SKShapeNode
    let mouth: SKShapeNode
    let eyeBlinkDelay: NSTimeInterval
    let eyeMoveDelay: NSTimeInterval
    
    init(sideLength: CGFloat, row: Int, col: Int, color: PieceColor, facialFeatures: Bool) {
               
        let actualSideLength = sideLength + 2
        let radius:CGFloat = actualSideLength / 5;
        let path = CGPathCreateMutable();
        let center = CGPoint(x: actualSideLength, y: actualSideLength * 2)
        let bottomLeft = CGPoint(x: 0, y: 0)
        let bottomRight = CGPoint(x: actualSideLength * 2, y: 0)
        CGPathMoveToPoint(path, nil, (center.x + bottomLeft.x) / 2, (center.y + bottomLeft.y) / 2);
        CGPathAddArcToPoint(path, nil, bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y, radius);
        CGPathAddArcToPoint(path, nil, bottomRight.x, bottomRight.y, center.x, center.y, radius);
        CGPathAddArcToPoint(path, nil, center.x, center.y, bottomLeft.x, bottomLeft.y, radius);
        CGPathCloseSubpath(path);
        
        let background = SKShapeNode(path: path, centered: true)
        
        let eyeSize = sideLength / 10
        eye = SKShapeNode(circleOfRadius: eyeSize)
        eyeBlinkDelay = NSTimeInterval(random(Range(start: 10, end: 20)))
        eyeMoveDelay = NSTimeInterval(random(Range(start: 2, end: 5)))
        mouth = SKShapeNode(rect: CGRect(x: -sideLength / 4, y: -sideLength / 2, width: sideLength / 2, height: eyeSize / 2), cornerRadius: 1)
        
        if facialFeatures {
            eye.fillColor = CustomColors.darkGray()
            eye.strokeColor = CustomColors.darkGray()
            eye.position = CGPoint(x: 0, y: actualSideLength / 3)
            eye.zPosition = 100
            


            mouth.strokeColor = CustomColors.darkGray()
            mouth.fillColor = CustomColors.darkGray()
            mouth.zPosition = 1
        }

        
        
        super.init(background: background, color: color, row: row, col: col)
        
        if facialFeatures {
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
        dit.background.strokeColor = SKColorForPieceColorEnum(color)
        dit.name = "DummyDit"
        return dit
    }
}