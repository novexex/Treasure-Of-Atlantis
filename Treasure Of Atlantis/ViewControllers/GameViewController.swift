//
//  GameViewController.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class GameViewController: UIViewController {
    
    var gameSetups: GameSetups!
    lazy var scoreAmount = gameSetups.scoreAmount {
        didSet {
            gameSetups.scoreAmount = scoreAmount
            for scene in sceneArray {
                scene.scoreAmount.text = "SCORE: " + menuScene.formatAmount(String(scoreAmount))
            }
        }
    }
    lazy var avatar = gameSetups.avatar {
        didSet {
            gameSetups.avatar = avatar
            saveGameSetup()
            for scene in sceneArray {
                scene.avatar.texture = SKTexture(imageNamed: avatar)
            }
        }
    }
    
    // MARK: Scene propertys
    private weak var prevScene: BaseScene?
    private weak var currentScene: BaseScene!
    private lazy var splashScene = SplashScene(size: view.bounds.size, gameController: self)
    
    private lazy var menuScene = MenuScene(size: view.bounds.size, gameController: self)
    private lazy var choosingLevelScene = ChoosingLevelScene(size: view.bounds.size, gameController: self)
    private lazy var lotteryScene = LotteryScene(size: view.bounds.size, gameController: self)
    private lazy var achivementsScene = AchivementsScene(size: view.bounds.size, gameController: self)
    private lazy var storeScene = StoreScene(size: view.bounds.size, gameController: self)
    private lazy var gameScene = GameScene(level: 1, size: view.bounds.size, gameController: self)
    private lazy var sceneArray = [menuScene, choosingLevelScene, lotteryScene, achivementsScene, storeScene, gameScene]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSKView()
        gameSetups = GameSetups()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func backButtonPressed() {
        if prevScene != nil && prevScene == choosingLevelScene {
            choosingLevelScene = ChoosingLevelScene(size: view.bounds.size, gameController: self)
            currentScene = choosingLevelScene
        } else if prevScene == nil {
            currentScene = menuScene
        } else {
            currentScene = prevScene
        }
        presentBaseScene(currentScene, saveCurrentScene: false)
    }
    
    func questionMarkButtonPressed() {
        
    }
    
    func gameOver(isWin: Bool, level: Int) {
        if isWin {
            print("win")
            gameSetups.isLevelCompleted[level] = true
            saveGameSetup()
        } else {
            print("lose")
        }
    }
    
    func startButtonPressed() {
        choosingLevelScene = ChoosingLevelScene(size: view.bounds.size, gameController: self)
        presentBaseScene(choosingLevelScene)
    }
    
    func startGameButtonPressed(level: Int) {
        gameScene = GameScene(level: level, size: view.bounds.size, gameController: self)
        presentBaseScene(gameScene)
    }
    
    func lotteryButtonPressed() {
        if !lotteryScene.isBonusClaimed {
            presentBaseScene(lotteryScene)
        } else {
            print("u have been claimed bonus")
        }
    }
    
    func policyButtonPressed() {
        
    }
    
    func achivementsButtonPressed() {
        presentBaseScene(achivementsScene)
    }
    
    func storeButtonPressed() {
        presentBaseScene(currentScene)
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
    
    private func presentBaseScene(_ scene: BaseScene, saveCurrentScene: Bool = true) {
        if let view = view as? SKView {
            if saveCurrentScene {
                prevScene = currentScene
            } else {
                prevScene = nil
            }
            currentScene.removeFromParent()
            currentScene = scene
            view.presentScene(currentScene)
        }
    }
}
