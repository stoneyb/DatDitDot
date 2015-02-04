import UIKit
import SpriteKit
import iAd

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //iAd
        let adBannerView = ADBannerView(frame: CGRect.zeroRect)
        adBannerView.center = CGPoint(x: view.frame.size.width / 2,
            y: view.frame.size.height - adBannerView.frame.size.height / 2)
        adBannerView.hidden = true
        
        //let scene = GameScene(size: view.bounds.size)
        let mainMenu = MainMenu(size: view.bounds.size)
        let skView = view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.showsDrawCount = true
        //scene.scaleMode = .AspectFill
        //skView.presentScene(scene)
        mainMenu.scaleMode = .AspectFill
        skView.presentScene(mainMenu)
        view.addSubview(adBannerView)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
