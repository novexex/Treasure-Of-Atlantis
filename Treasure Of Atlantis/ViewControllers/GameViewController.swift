//
//  GameViewController.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class GameViewController: UIViewController {
    
    var scoreAmount = 0
    var avatar = Resources.Avatars.siren
    
    var gameSetups: GameSetups!
    
    // MARK: Scene propertys
    private weak var currentScene: BaseScene!
    
    private lazy var splashScene = SplashScene(size: view.bounds.size, gameController: self)
    private lazy var menuScene = MenuScene(size: view.bounds.size, gameController: self)
    private lazy var choosingLevelScene = ChoosingLevelScene(size: view.bounds.size, gameController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSKView()
        gameSetups = GameSetups()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func backButtonPressed() {
        presentBaseScene(menuScene)
    }
    
    func questionMarkButtonPressed() {
        
    }
    
    func startButtonPressed() {
        choosingLevelScene = ChoosingLevelScene(size: view.bounds.size, gameController: self)
        presentBaseScene(choosingLevelScene)
    }
    
    func startGameButtonPressed(level: Int) {
        
    }
    
    func lotteryButtonPressed() {
        
    }
    
    func policyButtonPressed() {
        
    }
    
    func achivementsButtonPressed() {
        
    }
    
    func storeButtonPressed() {
        
    }
    
    func presentMenu() {
        presentBaseScene(menuScene)
    }
    
    private func loadGameSetup() {
        if let savedGameSetups = UserDefaults.standard.object(forKey: Resources.UserDefaultsKeys.gameSetups) as? Data {
            if let loadedGameSetups = try? JSONDecoder().decode(GameSetups.self, from: savedGameSetups) {
                gameSetups = loadedGameSetups
            }
        } else {
            gameSetups = GameSetups()
        }
    }
    
    private func saveGameSetup() {
        if let encoded = try? JSONEncoder().encode(gameSetups) {
            UserDefaults.standard.set(encoded, forKey: Resources.UserDefaultsKeys.gameSetups)
        }
    }
    
    private func getSKView() {
        let skView = SKView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        skView.ignoresSiblingOrder = true
        skView.showsNodeCount = true // temp
        skView.showsFPS = true       // temp
        self.view = skView
        currentScene = splashScene
        skView.presentScene(currentScene)
    }
    
    private func presentBaseScene(_ scene: BaseScene) {
        if let view = view as? SKView {
            currentScene.removeFromParent()
            currentScene = scene
            view.presentScene(currentScene)
        }
    }
}
