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
//                    case Resources.Buttons.siren:
//                        
//                    case Resources.Buttons.triton:
//                        
//                    case Resources.Buttons.ceratiidae:
//                        
//                    case Resources.Buttons.kraken:
//                        
                    default: break
                }
            }
        }
    }
    
    override func setupUI() {
        setBackground(with: Resources.Backgrounds.store)
        setupTopAndBotUI()
        setupBackAndQuestionMarkButtons()
        
        let sirenButton = SKSpriteNode(imageNamed: Resources.Buttons.siren)
        sirenButton.name = Resources.Buttons.siren
        sirenButton.position = CGPoint(x: frame.midX, y: leftButton.frame.minY - 140)
        addChild(sirenButton)
        
        let tritonButton = SKSpriteNode(imageNamed: Resources.Buttons.triton)
        tritonButton.name = Resources.Buttons.triton
        tritonButton.position = CGPoint(x: sirenButton.position.x, y: sirenButton.frame.midY - sirenButton.frame.height - 8)
        addChild(tritonButton)
        
        let ceratiidaeButton = SKSpriteNode(imageNamed: Resources.Buttons.ceratiidae)
        ceratiidaeButton.name = Resources.Buttons.ceratiidae
        ceratiidaeButton.position = CGPoint(x: tritonButton.position.x, y: tritonButton.frame.midY - tritonButton.frame.height - 25)
        addChild(ceratiidaeButton)
        
        let krakenButton = SKSpriteNode(imageNamed: Resources.Buttons.kraken)
        krakenButton.name = Resources.Buttons.kraken
        krakenButton.position = CGPoint(x: ceratiidaeButton.position.x, y: ceratiidaeButton.frame.midY - ceratiidaeButton.frame.height - 12)
        addChild(krakenButton)
    }
}
