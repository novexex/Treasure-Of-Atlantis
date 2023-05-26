//
//  BaseScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class BaseScene: SKScene {
    weak var gameController: GameViewController!
    
    var scoreAmount = SKLabelNode()
    var avatar = SKSpriteNode()
    
    private var leftButton = SKSpriteNode()
    private var rightButton = SKSpriteNode()
    private var middleLabel = SKSpriteNode()
    
    init(size: CGSize, gameController: GameViewController) {
        self.gameController = gameController
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        setupUI()
    }
    
    func setupUI() {
        removeAllChildren()
    }
    
    func setBackground(with imageNamed: String) {
        let background = SKSpriteNode(imageNamed: imageNamed)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.scale(to: frame.size)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupTopAndBotUI() {
        middleLabel = SKSpriteNode(imageNamed: Resources.Elements.score)
        middleLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 80)
        addChild(middleLabel)
        
        avatar = SKSpriteNode(imageNamed: gameController.avatar)
        avatar.position = CGPoint(x: middleLabel.frame.midX - 75, y: middleLabel.frame.midY)
        avatar.zPosition = 1
        addChild(avatar)
        
        scoreAmount = SKLabelNode(text: "SCORE: " + formatAmount(String(gameController.scoreAmount)))
        scoreAmount.fontName = Resources.Fonts.EvilEmpire_Regular
        scoreAmount.horizontalAlignmentMode = .center
        scoreAmount.fontSize = 25
        scoreAmount.position = CGPoint(x: avatar.position.x + 95, y: middleLabel.frame.midY - 9.5)
        scoreAmount.zPosition = 1
        addChild(scoreAmount)
        
        let policyButton = SKSpriteNode(imageNamed: Resources.Buttons.policy)
        policyButton.name = Resources.Buttons.policy
        policyButton.position = CGPoint(x: frame.midX, y: frame.minY + 85)
        addChild(policyButton)
    }
    
    private func setupLabelForRightButton() {
        rightButton = SKSpriteNode(imageNamed: Resources.Buttons.right)
        rightButton.name = Resources.Buttons.right
        rightButton.position = CGPoint(x: middleLabel.frame.maxX + 35, y: middleLabel.frame.midY)
        addChild(rightButton)
    }
    
    private func setupLabelForLeftButton() {
        leftButton = SKSpriteNode(imageNamed: Resources.Buttons.left)
        leftButton.name = Resources.Buttons.left
        leftButton.position = CGPoint(x: middleLabel.frame.minX - 35, y: middleLabel.frame.midY)
        addChild(leftButton)
    }
    
    func setupGameOverUI() {
        let lotteryButton = SKSpriteNode(imageNamed: Resources.Buttons.lottery)
        lotteryButton.name = Resources.Buttons.lottery
        if let size = lotteryButton.texture?.size() {
            lotteryButton.size = CGSize(width: size.width * 0.7, height: size.height * 0.7)
        }
        lotteryButton.position = CGPoint(x: frame.midX, y: frame.minY + 165)
        addChild(lotteryButton)
        
        middleLabel = SKSpriteNode(imageNamed: Resources.Elements.score)
        middleLabel.position = CGPoint(x: frame.midX, y: lotteryButton.frame.maxY + 80)
        addChild(middleLabel)
        
        scoreAmount = SKLabelNode(text: "SCORE: " + formatAmount(String(gameController.scoreAmount)))
        scoreAmount.fontName = Resources.Fonts.EvilEmpire_Regular
        scoreAmount.horizontalAlignmentMode = .center
        scoreAmount.fontSize = 25
        scoreAmount.position = CGPoint(x: frame.midX, y: middleLabel.frame.midY - 9.5)
        scoreAmount.zPosition = 1
        addChild(scoreAmount)
        
        setupStoreButton()
        setupLabelForRightButton()
        let shieldButton = SKSpriteNode(imageNamed: Resources.Buttons.shield)
        shieldButton.name = Resources.Buttons.shield
        shieldButton.position = CGPoint(x: rightButton.frame.midX - 5, y: rightButton.frame.midY)
        shieldButton.zPosition = 1
        addChild(shieldButton)
    }
    
    func setupBackButton() {
        setupLabelForLeftButton()
        
        let backButton = SKSpriteNode(imageNamed: Resources.Buttons.back)
        backButton.name = Resources.Buttons.back
        backButton.position = CGPoint(x: leftButton.frame.midX + 5, y: leftButton.frame.midY)
        backButton.zPosition = 1
        addChild(backButton)
    }
    
    func setupAchivementsButton() {
        setupLabelForRightButton()
        let achivmentsButton = SKSpriteNode(imageNamed: Resources.Buttons.achivements)
        achivmentsButton.name = Resources.Buttons.achivements
        achivmentsButton.position = CGPoint(x: rightButton.frame.midX - 6, y: rightButton.frame.midY)
        achivmentsButton.zPosition = 1
        addChild(achivmentsButton)
    }
    
    func setupStoreButton() {
        setupLabelForLeftButton()
        let storeButton = SKSpriteNode(imageNamed: Resources.Buttons.store)
        storeButton.name = Resources.Buttons.store
        storeButton.position = CGPoint(x: leftButton.frame.midX + 5, y: leftButton.frame.midY)
        storeButton.zPosition = 1
        addChild(storeButton)
    }
    
    func setupRefreshButton() {
        setupLabelForRightButton()
        let refreshButton = SKSpriteNode(imageNamed: Resources.Buttons.refersh)
        refreshButton.name = Resources.Buttons.refersh
        refreshButton.position = CGPoint(x: rightButton.frame.midX - 6, y: rightButton.frame.midY)
        refreshButton.zPosition = 1
        addChild(refreshButton)
    }
    
    func formatAmount(_ amount: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        
        if let number = formatter.number(from: amount) {
            return formatter.string(from: number) ?? ""
        }
        return ""
    }
}
