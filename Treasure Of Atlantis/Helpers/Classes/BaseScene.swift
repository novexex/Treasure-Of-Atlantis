//
//  BaseScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class BaseScene: SKScene {
    weak var gameController: GameViewController!
    
    var leftButton = SKSpriteNode()
    var rightButton = SKSpriteNode()
    var scoreAmount = SKLabelNode()
    
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
    
    func setupTopAndBotUI(with score: Int, and avatar: String) {
        let middleLabel = SKSpriteNode(imageNamed: Resources.Elements.score)
        middleLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 80)
        addChild(middleLabel)
        
        let avatar = SKSpriteNode(imageNamed: avatar)
        avatar.position = CGPoint(x: middleLabel.frame.midX - 75, y: middleLabel.frame.midY)
        avatar.zPosition = 1
        addChild(avatar)
        
        scoreAmount = SKLabelNode(text: "SCORE: " + formatAmount(String(score)))
        scoreAmount.fontName = Resources.Fonts.EvilEmpire_Regular
        scoreAmount.horizontalAlignmentMode = .center
        scoreAmount.fontSize = 25
        scoreAmount.position = CGPoint(x: avatar.position.x + 95, y: middleLabel.frame.midY - 9.5)
        scoreAmount.zPosition = 1
        addChild(scoreAmount)
        
        leftButton = SKSpriteNode(imageNamed: Resources.Buttons.left)
        leftButton.name = Resources.Buttons.left
        leftButton.position = CGPoint(x: middleLabel.frame.minX - 35, y: middleLabel.frame.midY)
        addChild(leftButton)
        
        rightButton = SKSpriteNode(imageNamed: Resources.Buttons.right)
        rightButton.name = Resources.Buttons.right
        rightButton.position = CGPoint(x: middleLabel.frame.maxX + 35, y: middleLabel.frame.midY)
        addChild(rightButton)
        
        let policyButton = SKSpriteNode(imageNamed: Resources.Buttons.policy)
        policyButton.name = Resources.Buttons.policy
        policyButton.position = CGPoint(x: frame.midX, y: frame.minY + 85)
        addChild(policyButton)
    }
    
    func setupBackAndQuestionMarkButtons() {
        let backButton = SKSpriteNode(imageNamed: Resources.Buttons.back)
        backButton.name = Resources.Buttons.back
        backButton.position = CGPoint(x: leftButton.frame.midX + 5, y: leftButton.frame.midY)
        backButton.zPosition = 1
        addChild(backButton)
        
        let questionMarkButton = SKSpriteNode(imageNamed: Resources.Buttons.questionMark)
        questionMarkButton.name = Resources.Buttons.questionMark
        questionMarkButton.position = CGPoint(x: rightButton.frame.midX - 5, y: rightButton.frame.midY)
        questionMarkButton.zPosition = 1
        addChild(questionMarkButton)
    }
    
    private func formatAmount(_ amount: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        
        if let number = formatter.number(from: amount) {
            return formatter.string(from: number) ?? ""
        }
        return ""
    }
}
