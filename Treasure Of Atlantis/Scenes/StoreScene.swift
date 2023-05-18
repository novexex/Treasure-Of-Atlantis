//
//  StoreScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class StoreScene: BaseScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let node = atPoint(touch.location(in: self)) as? SKSpriteNode {
                switch node.name {
                    case Resources.Buttons.left,
                        Resources.Buttons.back:
                        gameController.backButtonPressed()
                    case Resources.Buttons.right,
                        Resources.Buttons.questionMark:
                        gameController.questionMarkButtonPressed()
                    case Resources.Buttons.policy:
                        gameController.policyButtonPressed()
                    case Resources.Buttons.siren:
                        gameController.avatar = Resources.Avatars.siren
                    case Resources.Buttons.triton:
                        if gameController.scoreAmount >= 500 {
                            gameController.scoreAmount -= 500
                            gameController.avatar = Resources.Avatars.triton
                        } else {
                            print("cant buy triton, not enoght score amount")
                        }
                    case Resources.Buttons.ceratiidae:
                        if gameController.scoreAmount >= 3000 {
                            gameController.scoreAmount -= 3000
                            gameController.avatar = Resources.Avatars.ceratiidae
                        } else {
                            print("cant buy ceratiidae, not enoght score amount")
                        }
                    case Resources.Buttons.kraken:
                        if gameController.scoreAmount >= 6000 {
                            gameController.scoreAmount -= 6000
                            gameController.avatar = Resources.Avatars.kraken
                        } else {
                            print("cant buy kraken, not enoght score amount")
                        }
                    default: break
                }
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        setBackground(with: Resources.Backgrounds.store)
        setupTopAndBotUI()
        setupBackButton()
        setupQuestionMarkButton()

        let sirenButton = SKSpriteNode(imageNamed: Resources.Buttons.siren)
        sirenButton.name = Resources.Buttons.siren
        sirenButton.position = CGPoint(x: frame.midX, y: frame.midY + 160)
        addChild(sirenButton)

        let tritonButton = SKSpriteNode(imageNamed: Resources.Buttons.triton)
        tritonButton.name = Resources.Buttons.triton
        tritonButton.position = CGPoint(x: sirenButton.position.x, y: sirenButton.frame.minY - (tritonButton.frame.height / 2) - 15)
        addChild(tritonButton)

        let ceratiidaeButton = SKSpriteNode(imageNamed: Resources.Buttons.ceratiidae)
        ceratiidaeButton.name = Resources.Buttons.ceratiidae
        ceratiidaeButton.position = CGPoint(x: tritonButton.position.x, y: tritonButton.frame.minY - (ceratiidaeButton.frame.height / 2) - 15)
        addChild(ceratiidaeButton)

        let krakenButton = SKSpriteNode(imageNamed: Resources.Buttons.kraken)
        krakenButton.name = Resources.Buttons.kraken
        krakenButton.position = CGPoint(x: ceratiidaeButton.position.x, y: ceratiidaeButton.frame.minY - (krakenButton.frame.height / 2) - 15)
        addChild(krakenButton)
    }
}
