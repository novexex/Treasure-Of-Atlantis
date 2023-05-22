
import SpriteKit
import SafariServices

class GameViewController: UIViewController {
    var gameSetups: GameSetups!
    var lastLotteryPlay: Date?
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
    private var alertController = UIAlertController()
    
    // MARK: Scene propertys
    private weak var prevScene: BaseScene?
    private weak var currentScene: BaseScene!
    
    private lazy var menuScene = MenuScene(size: view.bounds.size, gameController: self)
    private lazy var choosingLevelScene = ChoosingLevelScene(size: view.bounds.size, gameController: self)
    private lazy var lotteryScene = LotteryScene(size: view.bounds.size, gameController: self)
    private lazy var achivementsScene = AchivementsScene(size: view.bounds.size, gameController: self)
    private lazy var storeScene = StoreScene(size: view.bounds.size, gameController: self)
    private lazy var gameScene = GameScene(level: 1, size: view.bounds.size, gameController: self)
    private lazy var winScene = WinScene(level: 1, levelScore: 0, size: view.bounds.size, gameController: self)
    private lazy var loseScene = LoseScene(level: 1, size: view.bounds.size, gameController: self)
    private lazy var sceneArray = [menuScene, choosingLevelScene, lotteryScene, achivementsScene, storeScene, gameScene]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameSetup()
        getSKView()
        setupAlerts()
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
        print("?")
    }
    
    func gameOver(isWin: Bool, level: Int, levelScore: Int) {
        if isWin {
            winScene = WinScene(level: level, levelScore: levelScore, size: view.bounds.size, gameController: self)
            presentBaseScene(winScene)
            gameSetups.isLevelCompleted[level] = true
            if level == 1 {
                gameSetups.isGuideMode = false
            }
            saveGameSetup()
        } else {
            loseScene = LoseScene(level: level, size: view.bounds.size, gameController: self)
            presentBaseScene(loseScene)
        }
    }
    
    func startButtonPressed() {
        choosingLevelScene = ChoosingLevelScene(size: view.bounds.size, gameController: self)
        presentBaseScene(choosingLevelScene)
    }
    
    func startGameButtonPressed(level: Int) {
        gameScene = GameScene(level: level, size: view.bounds.size, gameController: self)
        sceneArray.removeLast()
        sceneArray.append(gameScene)
        presentBaseScene(gameScene)
    }
    
    func lotteryButtonPressed() {
        if let lastLotteryPlay {
            if Calendar.current.isDateInToday(lastLotteryPlay) {
                present(alertController, animated: true)
            } else {
                lotteryScene.isBonusClaimed = false
                presentBaseScene(lotteryScene)
            }
        } else {
            presentBaseScene(lotteryScene)
        }
    }
    
    func policyButtonPressed() {
        if let url = URL(string: Resources.Links.policy) {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
    
    func achivementsButtonPressed() {
        presentBaseScene(achivementsScene)
    }
    
    func storeButtonPressed() {
        presentBaseScene(storeScene)
    }
    
    func presentMenu() {
        presentBaseScene(menuScene)
    }
    
    func loadGameSetup() {
        if let savedGameSetups = UserDefaults.standard.object(forKey: Resources.UserDefaultsKeys.gameSetups) as? Data {
            if let loadedGameSetups = try? JSONDecoder().decode(GameSetups.self, from: savedGameSetups) {
                self.gameSetups = loadedGameSetups
            }
        } else {
            gameSetups = GameSetups()
        }
        
        if let savedDate = UserDefaults.standard.object(forKey: Resources.UserDefaultsKeys.lastLotteryPlay) as? Date {
            lastLotteryPlay = savedDate
        }
    }
    
    func saveGameSetup() {
        if let encoded = try? JSONEncoder().encode(gameSetups) {
            UserDefaults.standard.set(encoded, forKey: Resources.UserDefaultsKeys.gameSetups)
            UserDefaults.standard.set(lastLotteryPlay, forKey: Resources.UserDefaultsKeys.lastLotteryPlay)
        }
    }
    
    private func setupAlerts() {
        alertController = UIAlertController(title: "", message: "You have been claimed bonus today", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
    }
    
    private func getSKView() {
        let skView = SKView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        skView.ignoresSiblingOrder = true
        skView.showsNodeCount = true // temp
        skView.showsFPS = true       // temp
        self.view = skView
        currentScene = menuScene
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
            view.presentScene(currentScene, transition: .fade(withDuration: 0.4))
        }
    }
}
