
import SpriteKit

class SplashViewController: UIViewController {
    
    private lazy var splashScene = SplashScene(size: view.bounds.size, gameController: GameViewController())
    
    override func viewDidLoad() {
        getSKView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.setAndPresentNewVC()
        }
    }
    
    private func getSKView() {
        let skView = SKView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        skView.ignoresSiblingOrder = true
        skView.showsNodeCount = true // temp
        skView.showsFPS = true       // temp
        self.view = skView
        skView.presentScene(splashScene)
    }
    
    private func setAndPresentNewVC() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let newRootViewController = appDelegate.gameController
        appDelegate.window?.rootViewController = newRootViewController
        present(newRootViewController ?? GameViewController(), animated: true)
    }
}
