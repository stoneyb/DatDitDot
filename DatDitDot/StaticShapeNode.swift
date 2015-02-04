import SpriteKit

class StaticxShapeNode: SKEffectNode {
    
    let shape: SKShapeNode

    init(shape: SKShapeNode) {
        self.shape = shape
        
        super.init()
        
        addChild(shape)
        shouldRasterize = true
    }
    
    var fillColor: SKColor {
        get {
            return shape.fillColor
        }
        set {
            shape.fillColor = newValue
        }
    }
    
    var strokeColor: SKColor {
        get {
            return shape.strokeColor
        }
        set {
            shape.strokeColor = newValue
        }
    }
    
    var lineWidth: CGFloat {
        get {
            return shape.lineWidth
        }
        set {
            shape.lineWidth = newValue
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
