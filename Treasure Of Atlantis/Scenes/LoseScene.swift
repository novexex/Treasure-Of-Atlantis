//
//  LoseScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class LoseScene: BaseScene {
    
    private lazy var currentLevel = gameController.gameSetups.currentLevel
    
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
                    case Resources.Buttons.restart:
                        gameController.startGameButtonPressed(level: currentLevel)
                    default: break
                }
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        setBackground(with: Resources.Backgrounds.lose)
        setupGameOverUI()
        
        let restartButton = SKSpriteNode(imageNamed: Resources.Buttons.restart)
        restartButton.name = Resources.Buttons.restart
        restartButton.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        addChild(restartButton)
    }
}
