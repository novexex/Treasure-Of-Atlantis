//
//  WinScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class WinScene: BaseScene {
    let level: Int
    let levelScore: Int
    
    init(level: Int, levelScore: Int, size: CGSize, gameController: GameViewController) {
        self.level = level
        self.levelScore = levelScore
        super.init(size: size, gameController: gameController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let node = atPoint(touch.location(in: self)) as? SKSpriteNode {
                switch node.name {
                    case Resources.Buttons.left,
                        Resources.Buttons.store:
                        gameController.storeButtonPressed()
                    case Resources.Buttons.right,
                        Resources.Buttons.shield:
                        gameController.policyButtonPressed()
                    case Resources.Buttons.lottery:
                        gameController.lotteryButtonPressed()
                    case Resources.Buttons.continue:
                        gameController.startButtonPressed()
                    default: break
                }
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        setBackground(with: Resources.Backgrounds.win)
        setupGameOverUI()
        
        let achivement = SKSpriteNode(imageNamed: gameController.gameSetups.getAchivementForLevel(level))
        if let size = achivement.texture?.size() {
            achivement.size = CGSize(width: size.width * 0.7, height: size.height * 0.7)
        }
        achivement.position = CGPoint(x: frame.midX, y: frame.midY + 10)
        addChild(achivement)
        
        let levelScoreAmount = SKLabelNode(text: "LEVEL SCORE: " + formatAmount(String(levelScore)))
        levelScoreAmount.fontName = Resources.Fonts.EvilEmpire_Regular
        levelScoreAmount.horizontalAlignmentMode = .center
        levelScoreAmount.fontSize = 30
        levelScoreAmount.position = CGPoint(x: frame.midX, y: achivement.frame.maxY + 10)
        levelScoreAmount.zPosition = 1
        addChild(levelScoreAmount)
        
        let continueButton = SKSpriteNode(imageNamed: Resources.Buttons.continue)
        continueButton.name = Resources.Buttons.continue
        if let size = continueButton.texture?.size() {
            continueButton.size = CGSize(width: size.width * 0.8, height: size.height * 0.8)
        }
        continueButton.position = CGPoint(x: frame.midX, y: achivement.frame.minY - (continueButton.size.height / 2) - 5)
        addChild(continueButton)
    }
}
