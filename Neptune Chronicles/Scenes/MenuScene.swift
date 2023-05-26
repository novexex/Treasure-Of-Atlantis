//
//  MenuScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class MenuScene: BaseScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let node = atPoint(touch.location(in: self)) as? SKSpriteNode {
                switch node.name {
                    case Resources.Buttons.left,
                        Resources.Buttons.store:
                        gameController.storeButtonPressed()
                    case Resources.Buttons.right,
                        Resources.Buttons.achivements:
                        gameController.achivementsButtonPressed()
                    case Resources.Buttons.start:
                        gameController.startButtonPressed()
                    case Resources.Buttons.lottery:
                        gameController.lotteryButtonPressed()
                    case Resources.Buttons.policy:
                        gameController.policyButtonPressed()
                    default: break
                }
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        setBackground(with: Resources.Backgrounds.menu)
        setupTopAndBotUI()
        setupStoreButton()
        setupAchivementsButton()
        
        let startButton = SKSpriteNode(imageNamed: Resources.Buttons.start)
        startButton.name = Resources.Buttons.start
        startButton.position = CGPoint(x: frame.midX, y: frame.midY - 130)
        addChild(startButton)
        
        let lotteryButton = SKSpriteNode(imageNamed: Resources.Buttons.lottery)
        lotteryButton.name = Resources.Buttons.lottery
        lotteryButton.position = CGPoint(x: frame.midX, y: startButton.frame.minY - 25)
        addChild(lotteryButton)
    }
}
