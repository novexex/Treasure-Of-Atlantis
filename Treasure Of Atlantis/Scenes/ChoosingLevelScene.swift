//
//  ChoosingLevelScene.swift
//  Treasure Of Atlantis
//
//  Created by Artour Ilyasov on 14.05.2023.
//

import SpriteKit

class ChoosingLevelScene: BaseScene {
    
    private var levels = [SKSpriteNode]()
    private var stars = [SKSpriteNode]()
    private var buttons = [SKSpriteNode]()
    
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
                    case Resources.Buttons.miniStartButton + "1":
                        gameController.startGameButtonPressed(level: 1)
                    case Resources.Buttons.miniStartButton + "2":
                        gameController.startGameButtonPressed(level: 2)
                    case Resources.Buttons.miniStartButton + "3":
                        gameController.startGameButtonPressed(level: 3)
                    case Resources.Buttons.miniStartButton + "4":
                        gameController.startGameButtonPressed(level: 4)
                    case Resources.Buttons.miniStartButton + "5":
                        gameController.startGameButtonPressed(level: 5)
                    case Resources.Buttons.policy:
                        gameController.policyButtonPressed()
                    default: break
                }
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
//        remove()
        
        setBackground(with: Resources.Backgrounds.choosingLevel)
        setupTopAndBotUI(with: gameController.scoreAmount, and: gameController.avatar)
        setupBackAndQuestionMarkButtons()
        
        let firstLevel = SKSpriteNode(imageNamed: Resources.Elements.firstLevel)
        firstLevel.position = CGPoint(x: (frame.width / 3) - 20, y: frame.midY + 90)
        levels.append(firstLevel)
        addChild(firstLevel)
        
        let secondLevel = SKSpriteNode(imageNamed: Resources.Elements.secondLevel)
        secondLevel.position = CGPoint(x: firstLevel.position.x + firstLevel.frame.width + 10, y: firstLevel.position.y)
        levels.append(secondLevel)
        addChild(secondLevel)
        
        let thirdLevel = SKSpriteNode(imageNamed: Resources.Elements.thirdLevel)
        thirdLevel.position = CGPoint(x: firstLevel.position.x, y: firstLevel.position.y - firstLevel.frame.height - 50)
        levels.append(thirdLevel)
        addChild(thirdLevel)
        
        let fourthLevel = SKSpriteNode(imageNamed: Resources.Elements.fourthLevel)
        fourthLevel.position = CGPoint(x: secondLevel.position.x, y: secondLevel.position.y - secondLevel.frame.height - 50)
        levels.append(fourthLevel)
        addChild(fourthLevel)
        
        let fifthLevel = SKSpriteNode(imageNamed: Resources.Elements.fifthLevel)
        fifthLevel.position = CGPoint(x: thirdLevel.position.x, y: thirdLevel.position.y - thirdLevel.frame.height - 50)
        levels.append(fifthLevel)
        addChild(fifthLevel)
        
        let bwLevel = SKSpriteNode(imageNamed: Resources.Elements.bwLevel)
        bwLevel.position = CGPoint(x: fourthLevel.position.x + 7, y: fourthLevel.position.y - fourthLevel.frame.height - 55.5)
        addChild(bwLevel)
        
        for i in 1...levels.count {
            var starsColor = String()
            if gameController.gameSetups.isLevelCompleted[i] ?? false {
                starsColor = Resources.Elements.stars
            } else {
                starsColor = Resources.Elements.bwStars
            }
            
            let stars = SKSpriteNode(imageNamed: starsColor)
            stars.position = CGPoint(x: levels[i-1].frame.midX + 3, y: levels[i-1].frame.maxY)
            stars.zPosition = 1
            self.stars.append(stars)
            addChild(stars)
            
            let miniStartButton = SKSpriteNode(imageNamed: Resources.Buttons.miniStartButton)
            miniStartButton.name = Resources.Buttons.miniStartButton + String(i)
            miniStartButton.position = CGPoint(x: levels[i-1].frame.midX, y: levels[i-1].frame.minY)
            miniStartButton.zPosition = 1
            buttons.append(miniStartButton)
            addChild(miniStartButton)
        }
    }
    
//    private func remove() {
//        for i in 0..<stars.count {
//            stars[i].removeFromParent()
//            buttons[i].removeFromParent()
//        }
//    }
}
