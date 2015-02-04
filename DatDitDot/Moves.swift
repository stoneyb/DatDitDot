import SpriteKit

class Moves {
    var movesArr: [SKNode]
    var moves: Int
 
    init() {
        movesArr = [SKNode]()
        moves = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moved() {
        if !movesArr.isEmpty {
            let node = movesArr.removeLast()
            node.runAction(SKAction.sequence([
                SKAction.group([
                    SKAction.moveByX(0, y: -30, duration: 0.5),
                    SKAction.fadeOutWithDuration(0.5)
                    ]),
                SKAction.removeFromParent()
                ]))
            self.moves--
        }
    }
    
    func createMovesBar(width: CGFloat) -> SKNode {
        self.clear()
        let moveBar = SKNode()
        moveBar.zPosition = 1
        
        let widthOffset: CGFloat = 0
        let actualWidth = width - widthOffset
        
        let margin: CGFloat = 1.0
        let movePieceWidth: CGFloat = (actualWidth - (margin * CGFloat(self.moves) - 1)) / CGFloat(self.moves)
        for i in 0..<self.moves {
            let moveBox = SKShapeNode(rectOfSize: CGSize(width: movePieceWidth, height: 10), cornerRadius: 3)
            moveBox.fillColor = CustomColors.darkGray()
            moveBox.strokeColor = SKColor.whiteColor()
            moveBox.position = CGPoint(x: widthOffset + (movePieceWidth / 2) + (movePieceWidth + margin) * CGFloat(i), y: 0)
            self.movesArr.append(moveBox)
            moveBar.addChild(moveBox)
        }
        return moveBar
    }
    
    func clear() {
        for moveNode in movesArr {
            moveNode.removeFromParent()
        }
        movesArr.removeAll(keepCapacity: true)
    }
}