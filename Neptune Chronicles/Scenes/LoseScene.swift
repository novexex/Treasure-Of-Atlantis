//
//  LoseScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class LoseScene: BaseScene {
    let level: Int
    
    init(level: Int, size: CGSize, gameController: GameViewController) {
        self.level = level
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
                    case Resources.Buttons.restart:
                        gameController.startGameButtonPressed(level: level)
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
